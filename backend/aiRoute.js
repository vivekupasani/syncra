const express = require("express");
const router = express.Router();
const aiController = require("./aiController");

router.post("/get-tokens", aiController.getTokens);
router.post("/text", aiController.textInput);
router.post("/image", aiController.imageInput);


module.exports = router;