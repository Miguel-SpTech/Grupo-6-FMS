var express = require("express");
var router = express.Router();
var colunaController = require('../controllers/colunaController');


router.get('/dashboard/:empresa', colunaController.buscarDados);

router.get("/dashboard/:empresa", function (req, res) {
    colunaController.buscarDados(req, res);
});

module.exports = router;