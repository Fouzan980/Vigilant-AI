const { admin, db } = require('../config/firebase');

exports.registerUser = async (req, res) => {
  try {
    const { id, name, email, role, district, phone } = req.body;
    
    await db.collection('users').doc(id).set({
      id,
      name,
      email,
      role: role || 'citizen',
      district: district || 'Unknown',
      phone: phone || '',
      reportsCount: 0,
      joinDate: new Date().toISOString(),
      isActive: true,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    res.status(201).json({ status: 'success', message: 'User registered/synced' });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ error: 'Registration failed' });
  }
};
