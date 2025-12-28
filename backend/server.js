require('dotenv').config();
const express = require('express');
const cors = require('cors');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Enable CORS for all routes
app.use(cors());

// Middleware to parse JSON
app.use(express.json());

// Import routes
const authRoutes = require('./routes/auth');

// Use routes
app.use('/api', authRoutes);

// GET endpoint for top selling items
app.get('/api/topselling', (req, res) => {
  try {
    const filePath = path.join(__dirname, 'data', 'topselling.json');
    
    // Read the JSON file
    const jsonData = fs.readFileSync(filePath, 'utf8');
    const data = JSON.parse(jsonData);
    
    // Return the data as JSON response
    res.status(200).json(data);
  } catch (error) {
    console.error('Error reading topselling.json:', error);
    res.status(500).json({ 
      error: 'Failed to fetch top selling items',
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
  console.log(`  - GET  http://localhost:${PORT}/health`);
});

