var colunaModel = require('../models/colunaModel');

exports.buscarDados = async (req, res) => {
  try {
    var { idEmpresa } = req.params;
    var dados = await colunaModel.buscarPorEmpresa(idEmpresa);
    res.json(dados);
  } catch (err) {
    res.status(500).json({ erro: err.message });
  }
};


module.exports = {
  router,
  express, colunaController, executar
};