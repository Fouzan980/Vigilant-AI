const { admin, db } = require("../config/firebase");

const REPORT_STATUSES = new Set(["open", "inProgress", "assigned", "resolved"]);

function parseLimit(value, fallback = 50) {
  const parsed = Number.parseInt(value, 10);
  if (Number.isNaN(parsed)) return fallback;
  return Math.min(Math.max(parsed, 1), 100);
}

function normalizeEnum(value, fallback) {
  if (typeof value !== "string" || value.trim() === "") return fallback;
  return value
    .trim()
    .replace(/\s+/g, "")
    .replace(/^./, (char) => char.toLowerCase());
}

function normalizeReportPayload(payload) {
  const description = payload.description?.toString().trim();
  if (!description && !Array.isArray(payload.photoUrls)) {
    const error = new Error("A description or photoUrls is required.");
    error.statusCode = 400;
    throw error;
  }

  const latitude =
    payload.latitude === undefined || payload.latitude === null
      ? null
      : Number(payload.latitude);
  const longitude =
    payload.longitude === undefined || payload.longitude === null
      ? null
      : Number(payload.longitude);

  if (latitude !== null && Number.isNaN(latitude)) {
    const error = new Error("latitude must be a number.");
    error.statusCode = 400;
    throw error;
  }

  if (longitude !== null && Number.isNaN(longitude)) {
    const error = new Error("longitude must be a number.");
    error.statusCode = 400;
    throw error;
  }

  return {
    userId: payload.userId || payload.uid || "anonymous",
    category: payload.category || "Other",
    subcategory: payload.subcategory || "",
    severity: normalizeEnum(payload.severity, "medium"),
    description: description || "",
    latitude,
    longitude,
    address: payload.address || payload.location || "Unknown location",
    location: payload.location || payload.address || "Unknown location",
    photoUrls: Array.isArray(payload.photoUrls) ? payload.photoUrls : [],
    isAnonymous: Boolean(payload.isAnonymous),
    audience: normalizeEnum(payload.audience, "public"),
    status: REPORT_STATUSES.has(payload.status) ? payload.status : "open",
    timestamp:
      payload.timestamp || payload.createdAt || new Date().toISOString(),
    assignedOfficerId: payload.assignedOfficerId || null,
  };
}

exports.getAllReports = async (req, res) => {
  try {
    const limit = parseLimit(req.query.limit);
    let query = db
      .collection("reports")
      .orderBy("timestamp", "desc")
      .limit(limit);

    if (req.query.status) {
      query = db
        .collection("reports")
        .where("status", "==", req.query.status)
        .limit(limit);
    }

    const snapshot = await query.get();
    const reports = [];
    snapshot.forEach((doc) => reports.push({ id: doc.id, ...doc.data() }));
    reports.sort((a, b) =>
      String(b.timestamp || "").localeCompare(String(a.timestamp || "")),
    );
    res.json(reports);
  } catch (error) {
    console.error("Fetch reports error:", error);
    res.status(500).json({ error: "Failed to fetch reports" });
  }
};

exports.getReportById = async (req, res) => {
  try {
    const doc = await db.collection("reports").doc(req.params.id).get();
    if (!doc.exists) {
      return res.status(404).json({ error: "Report not found" });
    }

    res.json({ id: doc.id, ...doc.data() });
  } catch (error) {
    console.error("Fetch report error:", error);
    res.status(500).json({ error: "Failed to fetch report" });
  }
};

exports.createReport = async (req, res) => {
  try {
    const reportData = normalizeReportPayload(req.body || {});

    const docRef = await db.collection("reports").add({
      ...reportData,
      serverTimestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    if (reportData.userId && reportData.userId !== "anonymous") {
      await db
        .collection("users")
        .doc(reportData.userId)
        .set(
          {
            reportsCount: admin.firestore.FieldValue.increment(1),
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true },
        );
    }

    res.status(201).json({
      status: "success",
      id: docRef.id,
      message: "Report submitted successfully",
    });
  } catch (error) {
    console.error("Report submission error:", error);
    res.status(error.statusCode || 500).json({
      error: error.statusCode ? error.message : "Report submission failed",
    });
  }
};

exports.updateReport = async (req, res) => {
  try {
    const reportRef = db.collection("reports").doc(req.params.id);
    const doc = await reportRef.get();
    if (!doc.exists) {
      return res.status(404).json({ error: "Report not found" });
    }

    const updates = { ...req.body };
    if (updates.severity)
      updates.severity = normalizeEnum(updates.severity, "medium");
    if (updates.audience)
      updates.audience = normalizeEnum(updates.audience, "public");
    if (updates.status && !REPORT_STATUSES.has(updates.status)) {
      return res.status(400).json({ error: "Invalid report status" });
    }

    delete updates.id;
    await reportRef.set(
      {
        ...updates,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true },
    );

    res.json({ status: "success", message: "Report updated successfully" });
  } catch (error) {
    console.error("Update report error:", error);
    res.status(500).json({ error: "Failed to update report" });
  }
};

exports.deleteReport = async (req, res) => {
  try {
    const reportRef = db.collection("reports").doc(req.params.id);
    const doc = await reportRef.get();
    if (!doc.exists) {
      return res.status(404).json({ error: "Report not found" });
    }

    await reportRef.delete();
    res.json({ status: "success", message: "Report deleted successfully" });
  } catch (error) {
    console.error("Delete report error:", error);
    res.status(500).json({ error: "Failed to delete report" });
  }
};
