var express = require("express");
var router = express.Router();


var kpiController = require('../controllers/kpiController');

router.get('/buscarKpi/:empresa', function (req, res) {
    kpiController.buscarKpi(req, res);
});

module.exports = router;