const express = require("express");
const router = express.Router();
const alertController = require("../controllers/alertController");

router.get("/", alertController.getActiveAlerts);
router.post("/", alertController.createAlert);
router.patch("/:id", alertController.updateAlert);

module.exports = router;
