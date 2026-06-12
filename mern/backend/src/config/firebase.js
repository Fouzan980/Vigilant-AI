const admin = require("firebase-admin");
const path = require("path");

if (
  process.env.NODE_ENV !== "production" &&
  process.env.USE_EMULATORS === "true"
) {
  process.env.FIREBASE_AUTH_EMULATOR_HOST =
    process.env.FIREBASE_AUTH_EMULATOR_HOST || "localhost:9099";
  process.env.FIRESTORE_EMULATOR_HOST =
    process.env.FIRESTORE_EMULATOR_HOST || "localhost:8080";
}

function buildCredential() {
  if (process.env.FIREBASE_CLIENT_EMAIL && process.env.FIREBASE_PRIVATE_KEY) {
    return admin.credential.cert({
      projectId: process.env.FIREBASE_PROJECT_ID,
      clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
      privateKey: process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, "\n"),
    });
  }

  try {
    const serviceAccount = require(
      path.join(__dirname, "../../serviceAccountKey.json"),
    );
    return admin.credential.cert(serviceAccount);
  } catch (error) {
    if (process.env.GOOGLE_APPLICATION_CREDENTIALS) {
      return admin.credential.applicationDefault();
    }

    if (process.env.USE_EMULATORS === "true") {
      return admin.credential.applicationDefault();
    }

    throw new Error(
      "Firebase credentials are missing. Provide serviceAccountKey.json, GOOGLE_APPLICATION_CREDENTIALS, or FIREBASE_CLIENT_EMAIL/FIREBASE_PRIVATE_KEY.",
    );
  }
}

if (!admin.apps.length) {
  admin.initializeApp({
    credential: buildCredential(),
    projectId: process.env.FIREBASE_PROJECT_ID,
  });
}

const db = admin.firestore();

module.exports = { admin, db };
