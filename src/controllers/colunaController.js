var colunaModel = require('../models/colunaModel');

exports.buscarDados = async (req, res) => {
  try {
    const {idEmpresa} = req.params;
    const dados = await colunaModel.buscarPorEmpresa(idEmpresa);
    res.json(dados);
  } catch (err) {
    res.status(500).json({ erro: err.message });
  }
};


