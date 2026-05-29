var express = require("express");
var router = express.Router();

var heatmapController = require("../controllers/heatmapController");

router.get("/heatmap/:id", function (req, res) {
    heatmapController.buscarHeatmap(req, res);
});

module.exports = router;