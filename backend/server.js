require('dotenv').config();
const express = require('express');
const cors = require('cors');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Enable CORS for all routes
app.use(cors());

// Middleware to parse JSON with increased limit for image uploads (10MB)
app.use(express.json({ limit: '10mb' }));

// Import routes
const authRoutes = require('./routes/auth');
const profileRoutes = require('./routes/profile');
const cartRoutes = require('./routes/cart');
const favoritesRoutes = require('./routes/favorites');
const prisma = require('./prisma/client');

// Use routes
app.use('/api', authRoutes);
app.use('/api', profileRoutes);
app.use('/api', cartRoutes);
app.use('/api', favoritesRoutes);

// GET endpoint for top selling items
app.get('/api/topselling', async (req, res) => {
  try {
    // Fetch 6 random items from the database using Prisma and PostgreSQL specific syntax
    const data = await prisma.$queryRaw`SELECT * FROM "Item" ORDER BY RANDOM() LIMIT 6`;

    // Return the data as JSON response
    res.status(200).json(data);
  } catch (error) {
    console.error('Error fetching top selling items:', error);
    res.status(500).json({
      error: 'Failed to fetch top selling items',
      message: error.message
    });
  }
});

// GET endpoint for all selling items
// GET endpoint for items with category filtering
// GET endpoint for items with category filtering
app.get('/api/items', async (req, res) => {
  try {
    const { category } = req.query;

    let where = {};
    if (category && category.toLowerCase() !== 'all') {
      where.category = {
        equals: category,
        mode: 'insensitive' // Case-insensitive filtering
      };
    }

    // Fetch items from database using Prisma
    const data = await prisma.item.findMany({
      where: where,
      orderBy: {
        createdAt: 'desc'
      }
    });

    // Return the data as JSON response
    res.status(200).json(data);
  } catch (error) {
    console.error('Error fetching items:', error);
    res.status(500).json({
      error: 'Failed to fetch items',
      message: error.message
    });
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK', message: 'Server is running' });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(err.status || 500).json({
    success: false,
    error: err.message || 'Internal server error',
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    error: 'Route not found',
  });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
  console.log(`API endpoints:`);
  console.log(`  - GET  http://localhost:${PORT}/api/topselling`);
  console.log(`  - POST http://localhost:${PORT}/api/signup`);
  console.log(`  - POST http://localhost:${PORT}/api/verify-otp`);
  console.log(`  - POST http://localhost:${PORT}/api/login`);
  console.log(`  - POST http://localhost:${PORT}/api/refresh-token`);
  console.log(`  - POST http://localhost:${PORT}/api/check-email`);
  console.log(`  - GET  http://localhost:${PORT}/api/profile`);
  console.log(`  - PUT  http://localhost:${PORT}/api/profile`);
  console.log(`  - POST http://localhost:${PORT}/api/cart`);
  console.log(`  - GET  http://localhost:${PORT}/api/cart`);
  console.log(`  - PUT  http://localhost:${PORT}/api/cart/:id`);
  console.log(`  - DEL  http://localhost:${PORT}/api/cart/:id`);
  console.log(`  - GET  http://localhost:${PORT}/health`);
  console.log(`  - GET  http://localhost:${PORT}/items`);
});

