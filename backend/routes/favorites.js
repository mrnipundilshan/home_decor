const express = require('express');
const router = express.Router();
const prisma = require('../prisma/client');
const { authenticateToken } = require('../utils/auth');

// Get user's favorite items
router.get('/favorites', authenticateToken, async (req, res) => {
    try {
        const userId = req.user.userId;

        const favorites = await prisma.favoriteItem.findMany({
            where: { userId },
            include: {
                item: true,
            },
            orderBy: {
                createdAt: 'desc',
            },
        });

        return res.status(200).json({
            success: true,
            data: favorites,
        });
    } catch (error) {
        console.error('Get favorites error:', error);
        return res.status(500).json({
            success: false,
            error: 'Failed to fetch favorites',
            message: error.message,
        });
    }
});

// Add item to favorites
router.post('/favorites', authenticateToken, async (req, res) => {
    try {
        const { itemId } = req.body;
        const userId = req.user.userId;

        if (!itemId) {
            return res.status(400).json({
                success: false,
                error: 'Item ID is required',
            });
        }

        // Check if item exists
        const item = await prisma.item.findUnique({
            where: { id: itemId },
        });

        if (!item) {
            return res.status(404).json({
                success: false,
                error: 'Item not found',
            });
        }

        // Check if already in favorites
        const existingFavorite = await prisma.favoriteItem.findUnique({
            where: {
                userId_itemId: {
                    userId,
                    itemId,
                },
            },
        });

        if (existingFavorite) {
            return res.status(200).json({
                success: true,
                data: existingFavorite,
                message: 'Item already in favorites',
            });
        }

        // Create favorite
        const favorite = await prisma.favoriteItem.create({
            data: {
                userId,
                itemId,
            },
            include: {
                item: true,
            },
        });

        return res.status(201).json({
            success: true,
            data: favorite,
            message: 'Item added to favorites successfully',
        });
    } catch (error) {
        console.error('Add favorite error:', error);
        return res.status(500).json({
            success: false,
            error: 'Failed to add item to favorites',
            message: error.message,
        });
    }
});

// Remove item from favorites (using itemId for convenience)
router.delete('/favorites/:itemId', authenticateToken, async (req, res) => {
    try {
        const { itemId } = req.params;
        const userId = req.user.userId;

        // Check if favorite exists
        const existingFavorite = await prisma.favoriteItem.findUnique({
            where: {
                userId_itemId: {
                    userId,
                    itemId,
                },
            },
        });

        if (!existingFavorite) {
            return res.status(404).json({
                success: false,
                error: 'Favorite not found',
            });
        }

        // Delete favorite
        await prisma.favoriteItem.delete({
            where: {
                userId_itemId: {
                    userId,
                    itemId,
                },
            },
        });

        return res.status(200).json({
            success: true,
            message: 'Item removed from favorites successfully',
        });
    } catch (error) {
        console.error('Delete favorite error:', error);
        return res.status(500).json({
            success: false,
            error: 'Failed to remove item from favorites',
            message: error.message,
        });
    }
});

module.exports = router;
