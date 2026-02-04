const express = require('express');
const router = express.Router();
const prisma = require('../prisma/client');
const { authenticateToken } = require('../utils/auth');

// Add item to cart
router.post('/cart', authenticateToken, async (req, res) => {
    try {
        const { itemId, quantity } = req.body;
        const userId = req.user.userId;

        // Validate input
        if (!itemId) {
            return res.status(400).json({
                success: false,
                error: 'Item ID is required',
            });
        }

        // Validate quantity
        const qty = quantity || 1;
        if (qty < 1) {
            return res.status(400).json({
                success: false,
                error: 'Quantity must be at least 1',
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

        // Check if item already in cart
        const existingCartItem = await prisma.cartItem.findUnique({
            where: {
                userId_itemId: {
                    userId,
                    itemId,
                },
            },
        });

        let cartItem;

        if (existingCartItem) {
            // Update quantity (increment)
            cartItem = await prisma.cartItem.update({
                where: { id: existingCartItem.id },
                data: {
                    quantity: existingCartItem.quantity + qty,
                },
                include: {
                    item: true,
                },
            });
        } else {
            // Create new cart item
            cartItem = await prisma.cartItem.create({
                data: {
                    userId,
                    itemId,
                    quantity: qty,
                },
                include: {
                    item: true,
                },
            });
        }

        return res.status(201).json({
            success: true,
            data: cartItem,
            message: 'Item added to cart successfully',
        });
    } catch (error) {
        console.error('Add to cart error:', error);
        return res.status(500).json({
            success: false,
            error: 'Failed to add item to cart',
            message: error.message,
        });
    }
});

// Get user's cart items
router.get('/cart', authenticateToken, async (req, res) => {
    try {
        const userId = req.user.userId;

        const cartItems = await prisma.cartItem.findMany({
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
            data: cartItems,
        });
    } catch (error) {
        console.error('Get cart error:', error);
        return res.status(500).json({
            success: false,
            error: 'Failed to fetch cart items',
            message: error.message,
        });
    }
});

// Update cart item quantity
router.put('/cart/:id', authenticateToken, async (req, res) => {
    try {
        const { id } = req.params;
        const { quantity } = req.body;
        const userId = req.user.userId;

        // Validate quantity
        if (!quantity || quantity < 1) {
            return res.status(400).json({
                success: false,
                error: 'Quantity must be at least 1',
            });
        }

        // Check if cart item exists and belongs to user
        const existingCartItem = await prisma.cartItem.findUnique({
            where: { id },
        });

        if (!existingCartItem) {
            return res.status(404).json({
                success: false,
                error: 'Cart item not found',
            });
        }

        if (existingCartItem.userId !== userId) {
            return res.status(403).json({
                success: false,
                error: 'Unauthorized to update this cart item',
            });
        }

        // Update quantity
        const updatedCartItem = await prisma.cartItem.update({
            where: { id },
            data: { quantity },
            include: {
                item: true,
            },
        });

        return res.status(200).json({
            success: true,
            data: updatedCartItem,
            message: 'Cart item updated successfully',
        });
    } catch (error) {
        console.error('Update cart error:', error);
        return res.status(500).json({
            success: false,
            error: 'Failed to update cart item',
            message: error.message,
        });
    }
});

// Remove item from cart
router.delete('/cart/:id', authenticateToken, async (req, res) => {
    try {
        const { id } = req.params;
        const userId = req.user.userId;

        // Check if cart item exists and belongs to user
        const existingCartItem = await prisma.cartItem.findUnique({
            where: { id },
        });

        if (!existingCartItem) {
            return res.status(404).json({
                success: false,
                error: 'Cart item not found',
            });
        }

        if (existingCartItem.userId !== userId) {
            return res.status(403).json({
                success: false,
                error: 'Unauthorized to delete this cart item',
            });
        }

        // Delete cart item
        await prisma.cartItem.delete({
            where: { id },
        });

        return res.status(200).json({
            success: true,
            message: 'Item removed from cart successfully',
        });
    } catch (error) {
        console.error('Delete cart error:', error);
        return res.status(500).json({
            success: false,
            error: 'Failed to remove item from cart',
            message: error.message,
        });
    }
});

module.exports = router;
