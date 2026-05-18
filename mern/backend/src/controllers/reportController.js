const { admin, db } = require('../config/firebase');

exports.getAllReports = async (req, res) => {
  try {
    const snapshot = await db.collection('reports').orderBy('timestamp', 'desc').limit(50).get();
    const reports = [];
    snapshot.forEach(doc => reports.push({ id: doc.id, ...doc.data() }));
    res.json(reports);
  } catch (error) {
    console.error('Fetch reports error:', error);
    res.status(500).json({ error: 'Failed to fetch reports' });
  }
};

exports.createReport = async (req, res) => {
  try {
    const reportData = req.body;
    
    const docRef = await db.collection('reports').add({
      ...reportData,
      status: reportData.status || 'open',
      timestamp: reportData.timestamp || new Date().toISOString(),
      serverTimestamp: admin.firestore.FieldValue.serverTimestamp()
    });

    res.status(201).json({ 
      status: 'success', 
      id: docRef.id,
      message: 'Report submitted successfully' 
    });
  } catch (error) {
    console.error('Report submission error:', error);
    res.status(500).json({ error: 'Report submission failed' });
  }
};
