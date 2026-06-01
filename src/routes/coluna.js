var express = require("express");
var router = express.Router();
var colunaController = require('../controllers/colunaController');


router.get('/dashboard/:empresa', colunaController.buscarDados);

module.exports = {
  router, 
};