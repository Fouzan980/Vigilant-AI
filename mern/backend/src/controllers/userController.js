const { admin, db } = require("../config/firebase");

exports.getAllUsers = async (req, res) => {
  try {
    const snapshot = await db
      .collection("users")
      .orderBy("joinDate", "desc")
      .limit(100)
      .get();
    const users = [];
    snapshot.forEach((doc) => users.push({ id: doc.id, ...doc.data() }));
    res.json(users);
  } catch (error) {
    console.error("Fetch users error:", error);
    res.status(500).json({ error: "Failed to fetch users" });
  }
};

exports.getUserById = async (req, res) => {
  try {
    const doc = await db.collection("users").doc(req.params.id).get();
    if (!doc.exists) {
      return res.status(404).json({ error: "User not found" });
    }

    res.json({ id: doc.id, ...doc.data() });
  } catch (error) {
    console.error("Fetch user error:", error);
    res.status(500).json({ error: "Failed to fetch user" });
  }
};

exports.registerUser = async (req, res) => {
  try {
    const { name, email, role, district, phone } = req.body;
    const id = req.body.id || req.body.uid;

    if (!id) {
      return res.status(400).json({ error: "User id is required" });
    }

    await db
      .collection("users")
      .doc(id)
      .set(
        {
          id,
          name,
          email,
          role: role || "citizen",
          district: district || "Unknown",
          phone: phone || "",
          reportsCount: 0,
          joinDate: new Date().toISOString(),
          isActive: true,
          status: "active",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true },
      );

    res
      .status(201)
      .json({ status: "success", message: "User registered/synced" });
  } catch (error) {
    console.error("Registration error:", error);
    res.status(500).json({ error: "Registration failed" });
  }
};

exports.updateUser = async (req, res) => {
  try {
    const updates = { ...req.body };
    delete updates.id;
    delete updates.uid;

    await db
      .collection("users")
      .doc(req.params.id)
      .set(
        {
          ...updates,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true },
      );

    res.json({ status: "success", message: "User updated successfully" });
  } catch (error) {
    console.error("Update user error:", error);
    res.status(500).json({ error: "Failed to update user" });
  }
};
