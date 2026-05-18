const admin = require('firebase-admin');
const path = require('path');
const serviceAccount = require(path.join(__dirname, '../../serviceAccountKey.json'));

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// Configure Firebase emulator host if we're in development
if (process.env.NODE_ENV !== 'production' && process.env.USE_EMULATORS === 'true') {
  process.env.FIREBASE_AUTH_EMULATOR_HOST = 'localhost:9099';
  process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
}

const db = admin.firestore();

module.exports = { admin, db };
