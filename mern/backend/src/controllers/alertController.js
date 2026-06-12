const { admin, db } = require("../config/firebase");

exports.getActiveAlerts = async (req, res) => {
  try {
    let query = db.collection("alerts").orderBy("timestamp", "desc").limit(100);
    if (req.query.active !== "false") {
      query = db.collection("alerts").where("isActive", "==", true).limit(100);
    }

    const snapshot = await query.get();
    const alerts = [];
    snapshot.forEach((doc) => alerts.push({ id: doc.id, ...doc.data() }));
    alerts.sort((a, b) =>
      String(b.timestamp || "").localeCompare(String(a.timestamp || "")),
    );
    res.json(alerts);
  } catch (error) {
    console.error("Fetch alerts error:", error);
    res.status(500).json({ error: "Failed to fetch alerts" });
  }
};

exports.createAlert = async (req, res) => {
  try {
    const payload = req.body || {};
    if (!payload.title) {
      return res.status(400).json({ error: "Alert title is required" });
    }

    const docRef = await db.collection("alerts").add({
      title: payload.title,
      subtitle: payload.subtitle || payload.description || "",
      severity: (payload.severity || "medium").toString().toLowerCase(),
      latitude:
        payload.latitude === undefined ? null : Number(payload.latitude),
      longitude:
        payload.longitude === undefined ? null : Number(payload.longitude),
      radius: payload.radius === undefined ? 1000 : Number(payload.radius),
      type: payload.type || "general",
      createdBy: payload.createdBy || "system",
      timestamp: payload.timestamp || new Date().toISOString(),
      isActive: payload.isActive !== false,
      targetAudience: payload.targetAudience || "public",
      serverTimestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    res.status(201).json({ status: "success", id: docRef.id });
  } catch (error) {
    console.error("Create alert error:", error);
    res.status(500).json({ error: "Failed to create alert" });
  }
};

exports.updateAlert = async (req, res) => {
  try {
    const updates = { ...req.body };
    delete updates.id;
    if (updates.severity)
      updates.severity = updates.severity.toString().toLowerCase();

    await db
      .collection("alerts")
      .doc(req.params.id)
      .set(
        {
          ...updates,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true },
      );

    res.json({ status: "success", message: "Alert updated successfully" });
  } catch (error) {
    console.error("Update alert error:", error);
    res.status(500).json({ error: "Failed to update alert" });
  }
};
