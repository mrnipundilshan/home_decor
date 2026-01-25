const { S3Client, PutObjectCommand } = require('@aws-sdk/client-s3');

// Initialize S3 client for Cloudflare R2
const s3Client = new S3Client({
  region: 'auto',
  endpoint: process.env.R2_ENDPOINT,
  credentials: {
    accessKeyId: process.env.R2_ACCESS_KEY_ID,
    secretAccessKey: process.env.R2_SECRET_ACCESS_KEY,
  },
});

// Public R2 URL base
const R2_PUBLIC_URL = 'https://pub-266a402752f1427784b1a80efb9929c7.r2.dev';

/**
 * Uploads an image buffer to Cloudflare R2
 * @param {Buffer} imageBuffer - The image file buffer
 * @param {string} fileName - The filename to use in R2
 * @param {string} contentType - The MIME type of the image (e.g., 'image/jpeg', 'image/png')
 * @returns {Promise<string>} - The public URL of the uploaded image
 */
async function uploadToR2(imageBuffer, fileName, contentType) {
  try {
    const command = new PutObjectCommand({
      Bucket: process.env.R2_BUCKET,
      Key: fileName,
      Body: imageBuffer,
      ContentType: contentType,
    });

    await s3Client.send(command);

    // Return the public URL
    return `${R2_PUBLIC_URL}/${fileName}`;
  } catch (error) {
    console.error('R2 upload error:', error);
    throw new Error(`Failed to upload image to R2: ${error.message}`);
  }
}

/**
 * Detects image format from buffer using magic bytes
 * @param {Buffer} buffer - Image buffer
 * @returns {string} - MIME type (e.g., 'image/jpeg', 'image/png')
 */
function detectImageType(buffer) {
  if (!buffer || buffer.length < 4) {
    return 'image/jpeg'; // Default fallback
  }

  // Check magic bytes (file signatures)
  const bytes = buffer.slice(0, 12);
  
  // JPEG: FF D8 FF
  if (bytes[0] === 0xFF && bytes[1] === 0xD8 && bytes[2] === 0xFF) {
    return 'image/jpeg';
  }
  
  // PNG: 89 50 4E 47 0D 0A 1A 0A
  if (bytes[0] === 0x89 && bytes[1] === 0x50 && bytes[2] === 0x4E && bytes[3] === 0x47) {
    return 'image/png';
  }
  
  // GIF: 47 49 46 38
  if (bytes[0] === 0x47 && bytes[1] === 0x49 && bytes[2] === 0x46 && bytes[3] === 0x38) {
    return 'image/gif';
  }
  
  // WebP: RIFF ... WEBP
  if (bytes[0] === 0x52 && bytes[1] === 0x49 && bytes[2] === 0x46 && bytes[3] === 0x46) {
    if (bytes.length >= 12 && 
        bytes[8] === 0x57 && bytes[9] === 0x45 && bytes[10] === 0x42 && bytes[11] === 0x50) {
      return 'image/webp';
    }
  }
  
  // Default to JPEG if format cannot be determined
  return 'image/jpeg';
}

/**
 * Decodes a base64 image string and extracts the image data and content type
 * @param {string} base64String - Base64 encoded image (with or without data URI prefix)
 * @returns {Object} - Object containing buffer and contentType
 */
function decodeBase64Image(base64String) {
  try {
    // Remove data URI prefix if present (e.g., "data:image/jpeg;base64,")
    let base64Data = base64String;
    let contentType = null;

    if (base64String.startsWith('data:')) {
      const matches = base64String.match(/^data:([^;]+);base64,(.+)$/);
      if (matches) {
        contentType = matches[1];
        base64Data = matches[2];
      } else {
        // Try to extract just the base64 part
        const commaIndex = base64String.indexOf(',');
        if (commaIndex !== -1) {
          const header = base64String.substring(0, commaIndex);
          const mimeMatch = header.match(/data:([^;]+)/);
          if (mimeMatch) {
            contentType = mimeMatch[1];
          }
          base64Data = base64String.substring(commaIndex + 1);
        }
      }
    }

    // Decode base64 to buffer first
    const buffer = Buffer.from(base64Data, 'base64');

    // Validate buffer is not empty
    if (buffer.length === 0) {
      throw new Error('Invalid image data: empty buffer');
    }

    // Validate buffer size (max 5MB)
    const maxSize = 5 * 1024 * 1024; // 5MB
    if (buffer.length > maxSize) {
      throw new Error('Image size exceeds maximum allowed size of 5MB');
    }

    // If content type wasn't extracted from data URI, detect it from buffer
    if (!contentType) {
      contentType = detectImageType(buffer);
    }

    // Validate content type is an image
    if (!contentType.startsWith('image/')) {
      throw new Error('Invalid image format');
    }

    return { buffer, contentType };
  } catch (error) {
    console.error('Base64 decode error:', error);
    throw new Error(`Failed to decode base64 image: ${error.message}`);
  }
}

/**
 * Generates a unique filename for profile images
 * @param {string} userId - The user ID
 * @param {string} contentType - The MIME type of the image
 * @returns {string} - Unique filename
 */
function generateProfileFileName(userId, contentType) {
  const timestamp = Date.now();
  const extension = contentType.split('/')[1] || 'jpg';
  return `profile-${userId}-${timestamp}.${extension}`;
}

/**
 * Main function to upload a base64 image to R2
 * @param {string} base64Image - Base64 encoded image string
 * @param {string} userId - The user ID for filename generation
 * @returns {Promise<string>} - The public URL of the uploaded image
 */
async function uploadProfileImage(base64Image, userId) {
  try {
    // Decode base64 image
    const { buffer, contentType } = decodeBase64Image(base64Image);

    // Generate unique filename
    const fileName = generateProfileFileName(userId, contentType);

    // Upload to R2
    const publicUrl = await uploadToR2(buffer, fileName, contentType);

    return publicUrl;
  } catch (error) {
    console.error('Upload profile image error:', error);
    throw error;
  }
}

/**
 * Checks if a string is a base64-encoded image
 * @param {string} str - String to check
 * @returns {boolean} - True if it's a base64 image, false otherwise
 */
function isBase64Image(str) {
  if (typeof str !== 'string' || str.length === 0) return false;
  
  // Check if it's a data URI with image prefix
  if (str.startsWith('data:image/')) {
    return true;
  }
  
  // Check if it's a raw base64 string (long enough and valid base64 characters)
  // Base64 strings are typically long (at least 100 chars for a small image)
  // and contain only base64 characters: A-Z, a-z, 0-9, +, /, =
  if (str.length > 100) {
    // Remove any whitespace
    const cleaned = str.trim().replace(/\s/g, '');
    // Check if it's valid base64 (only base64 characters, ends with = or valid base64 char)
    const base64Regex = /^[A-Za-z0-9+/]+={0,2}$/;
    if (base64Regex.test(cleaned)) {
      // Try to decode a small portion to verify it's valid base64
      try {
        Buffer.from(cleaned.substring(0, 100), 'base64');
        return true;
      } catch (e) {
        return false;
      }
    }
  }
  
  return false;
}

module.exports = {
  uploadProfileImage,
  isBase64Image,
};
