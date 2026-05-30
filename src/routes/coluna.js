
const express = require('express');
const router = express.Router();
const colunaController = require('../controllers/colunaController');

router.get('/dashboard/:empresa', colunaController.buscarDados);

module.exports = router;