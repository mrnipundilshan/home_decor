const express = require('express');
const router = express.Router();
const prisma = require('../prisma/client');
const { authenticateToken } = require('../utils/auth');

// GET /api/profile - Retrieve user profile
router.get('/profile', authenticateToken, async (req, res) => {
  try {
    const userId = req.user.userId;

    // Find user with profile
    const user = await prisma.user.findUnique({
      where: { id: userId },
      include: { profile: true },
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        error: 'User not found',
      });
    }

    // If profile doesn't exist, create it automatically
    let profile = user.profile;
    if (!profile) {
      // Create a minimal profile with just userId (all other fields will be null)
      profile = await prisma.profile.upsert({
        where: { userId },
        update: {}, // No update needed if it exists
        create: {
          userId,
        },
      });
    }

    // Return profile data with email from User table
    return res.status(200).json({
      success: true,
      profile: {
        id: profile.id,
        email: user.email,
        profileImage: profile.profileImage,
        firstName: profile.firstName,
        lastName: profile.lastName,
        dob: profile.dob,
        phoneNumber: profile.phoneNumber,
        gender: profile.gender,
        createdAt: profile.createdAt,
        updatedAt: profile.updatedAt,
      },
    });
  } catch (error) {
    console.error('Get profile error:', error);
    return res.status(500).json({
      success: false,
      error: 'Failed to retrieve profile',
      message: error.message,
    });
  }
});

// PUT /api/profile - Update or create user profile
router.put('/profile', authenticateToken, async (req, res) => {
  try {
    const userId = req.user.userId;
    const { profileImage, firstName, lastName, dob, phoneNumber, gender } = req.body;

    // Validate that user exists
    const user = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        error: 'User not found',
      });
    }

    // Prepare update data (only include provided fields)
    const updateData = {};
    if (profileImage !== undefined) updateData.profileImage = profileImage;
    if (firstName !== undefined) updateData.firstName = firstName;
    if (lastName !== undefined) updateData.lastName = lastName;
    if (dob !== undefined) updateData.dob = dob;
    if (phoneNumber !== undefined) updateData.phoneNumber = phoneNumber;
    if (gender !== undefined) updateData.gender = gender;

    // Upsert profile (create if doesn't exist, update if exists)
    const profile = await prisma.profile.upsert({
      where: { userId },
      update: updateData,
      create: {
        userId,
        ...updateData,
      },
    });

    // Return profile data with email from User table
    return res.status(200).json({
      success: true,
      message: 'Profile updated successfully',
      profile: {
        id: profile.id,
        email: user.email,
        profileImage: profile.profileImage,
        firstName: profile.firstName,
        lastName: profile.lastName,
        dob: profile.dob,
        phoneNumber: profile.phoneNumber,
        gender: profile.gender,
        createdAt: profile.createdAt,
        updatedAt: profile.updatedAt,
      },
    });
  } catch (error) {
    console.error('Update profile error:', error);
    return res.status(500).json({
      success: false,
      error: 'Failed to update profile',
      message: error.message,
    });
  }
});

module.exports = router;

