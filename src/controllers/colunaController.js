var colunaModel = require('../models/colunaModel');

function buscarDados(req, res) {
    var { idEmpresa } = req.params;
    var dados = colunaModel.buscarPorEmpresa(idEmpresa);
    res.json(dados);
 
};


module.exports = {
  buscarDados
};