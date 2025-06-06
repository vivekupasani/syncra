const express = require("express");
const router = express.Router();
const aiController = require("./aiController");

router.post("/text", aiController.reviewCode);


module.exports = router;