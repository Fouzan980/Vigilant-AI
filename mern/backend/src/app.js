const express = require('express');
const cors = require('cors');
const userRoutes = require('./routes/userRoutes');
const reportRoutes = require('./routes/reportRoutes');
const alertRoutes = require('./routes/alertRoutes');

const app = express();

app.use(cors());
app.use(express.json());

// Health Check
app.get('/api/v1/health', (req, res) => {
  res.json({ status: 'ok', message: 'Vigilant Backend API is running' });
});

// Routes
app.use('/api/v1/users', userRoutes);
app.use('/api/v1/reports', reportRoutes);
app.use('/api/v1/alerts', alertRoutes);

module.exports = app;
