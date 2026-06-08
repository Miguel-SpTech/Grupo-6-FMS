var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/cadastrarDash", function (req, res) {
    usuarioController.cadastrarDash(req, res);
})

router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res);
});

router.get("/pendentes", function (req, res) {
    usuarioController.buscarPendentes(req, res);
});

router.get("/status-restaurante/:id", function (req, res) {
    usuarioController.verificarStatusRestaurante(req, res);
});

router.post("/aprovar/:id", function (req, res) {
    usuarioController.aprovarSolicitacao(req, res);
});

router.post("/recusar/:id", function (req, res) {
    usuarioController.recusarSolicitacao(req, res);
});

module.exports = router;