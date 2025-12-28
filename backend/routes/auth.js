const express = require('express');
const router = express.Router();
const prisma = require('../prisma/client');
const {
  hashPassword,
  comparePassword,
  generateOTP,
  generateAccessToken,
  generateRefreshToken,
  verifyRefreshToken,
  isValidEmail,
  isValidPassword,
} = require('../utils/auth');

// Signup endpoint
router.post('/signup', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Validate input
    if (!email || !password) {
      return res.status(400).json({
        success: false,
        error: 'Email and password are required',
      });
    }

    // Validate email format
    if (!isValidEmail(email)) {
      return res.status(400).json({
        success: false,
        error: 'Invalid email format',
      });
    }

    // Validate password strength
    if (!isValidPassword(password)) {
      return res.status(400).json({
        success: false,
        error: 'Password must be at least 6 characters long',
      });
    }

    // Check if user already exists
    const existingUser = await prisma.user.findUnique({
      where: { email: email.toLowerCase() },
    });

    if (existingUser) {
      return res.status(409).json({
        success: false,
        error: 'User with this email already exists',
      });
    }

    // Hash password
    const hashedPassword = await hashPassword(password);

    // Generate OTP
    const otp = generateOTP();
    const otpExpiryMinutes = parseInt(process.env.OTP_EXPIRY_MINUTES) || 10;
    const otpExpiry = new Date(Date.now() + otpExpiryMinutes * 60 * 1000);

    // Create user
    await prisma.user.create({
      data: {
        email: email.toLowerCase(),
        password: hashedPassword,
        otp,
        otpExpiry,
        isVerified: false,
      },
    });

    // Return OTP (in production, send via email/SMS)
    return res.status(201).json({
      success: true,
      otp, // Remove this in production and send via email/SMS
      message: 'OTP sent to email',
    });
  } catch (error) {
    console.error('Signup error:', error);
    return res.status(500).json({
      success: false,
      error: 'Failed to create account',
      message: error.message,
    });
  }
});

// Verify OTP endpoint
router.post('/verify-otp', async (req, res) => {
  try {
    const { email, otp } = req.body;

    // Validate input
    if (!email || !otp) {
      return res.status(400).json({
        success: false,
        error: 'Email and OTP are required',
      });
    }

    // Find user
    const user = await prisma.user.findUnique({
      where: { email: email.toLowerCase() },
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        error: 'User not found',
      });
    }

    // Check if already verified
    if (user.isVerified) {
      return res.status(400).json({
        success: false,
        error: 'Account is already verified',
      });
    }

    // Check if OTP exists
    if (!user.otp) {
      return res.status(400).json({
        success: false,
        error: 'No OTP found. Please sign up again',
      });
    }

    // Verify OTP
    if (user.otp !== otp) {
      return res.status(400).json({
        success: false,
        error: 'Invalid OTP',
      });
    }

    // Check if OTP is expired
    if (!user.otpExpiry || new Date() > new Date(user.otpExpiry)) {
      return res.status(400).json({
        success: false,
        error: 'OTP has expired. Please request a new one',
      });
    }

    // Update user: verify account and clear OTP
    await prisma.user.update({
      where: { id: user.id },
      data: {
        isVerified: true,
        otp: null,
        otpExpiry: null,
      },
    });

    return res.status(200).json({
      success: true,
      message: 'Account verified successfully',
    });
  } catch (error) {
    console.error('Verify OTP error:', error);
    return res.status(500).json({
      success: false,
      error: 'Failed to verify OTP',
      message: error.message,
    });
  }
});

// Login endpoint
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Validate input
    if (!email || !password) {
      return res.status(400).json({
        success: false,
        error: 'Email and password are required',
      });
    }

    // Find user
    const user = await prisma.user.findUnique({
      where: { email: email.toLowerCase() },
    });

    if (!user) {
      return res.status(401).json({
        success: false,
        error: 'Invalid email or password',
      });
    }

    // Verify password
    const isPasswordValid = await comparePassword(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({
        success: false,
        error: 'Invalid email or password',
      });
    }

    // Check if account is verified
    if (!user.isVerified) {
      return res.status(403).json({
        success: false,
        error: 'Account not verified. Please verify your email first',
      });
    }

    // Generate tokens
    const accessToken = generateAccessToken(user.id);
    const refreshToken = generateRefreshToken(user.id);

    return res.status(200).json({
      success: true,
      accessToken,
      refreshToken,
      user: {
        id: user.id,
        email: user.email,
      },
    });
  } catch (error) {
    console.error('Login error:', error);
    return res.status(500).json({
      success: false,
      error: 'Failed to login',
      message: error.message,
    });
  }
});

// Refresh token endpoint
router.post('/refresh-token', async (req, res) => {
  try {
    const { refreshToken } = req.body;

    // Validate input
    if (!refreshToken) {
      return res.status(400).json({
        success: false,
        error: 'Refresh token is required',
      });
    }

    // Verify refresh token
    const decoded = verifyRefreshToken(refreshToken);
    if (!decoded) {
      return res.status(401).json({
        success: false,
        error: 'Invalid or expired refresh token',
      });
    }

    // Extract userId from decoded token
    const userId = decoded.userId;

    // Generate new access token
    const newAccessToken = generateAccessToken(userId);

    return res.status(200).json({
      success: true,
      accessToken: newAccessToken,
    });
  } catch (error) {
    console.error('Refresh token error:', error);
    return res.status(500).json({
      success: false,
      error: 'Failed to refresh token',
      message: error.message,
    });
  }
});

module.exports = router;

