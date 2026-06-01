
var express = require('express');
var router = express.Router();
var colunaController = require('../controllers/colunaController');
const { executar } = require('../database/config');

router.get('/dashboard/:empresa', colunaController.buscarDados);

module.exports = {
  router,
  express, colunaController, executar
};