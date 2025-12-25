const express = require('express');
const cors = require('cors');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;

// Enable CORS for all routes
app.use(cors());

// Middleware to parse JSON
app.use(express.json());

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

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
  console.log(`API endpoint: http://localhost:${PORT}/api/topselling`);
});

