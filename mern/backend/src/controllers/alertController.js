const { db } = require('../config/firebase');

exports.getActiveAlerts = async (req, res) => {
  try {
    const snapshot = await db.collection('alerts').where('isActive', '==', true).get();
    const alerts = [];
    snapshot.forEach(doc => alerts.push({ id: doc.id, ...doc.data() }));
    res.json(alerts);
  } catch (error) {
    console.error('Fetch alerts error:', error);
    res.status(500).json({ error: 'Failed to fetch alerts' });
  }
};
