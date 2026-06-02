var colunaModel = require('../models/colunaModel');

async function buscarDados(req, res) {
    var  idEmpresa = req.params.empresa;
    var dados = await colunaModel.buscarPorEmpresa(idEmpresa);

    const dadosTratados = dados.map(dia => ({
        diaSemana: dia.dia_na_semana_num - 1,
        total_clientes: dia.total_movimentacao
    }))
console.log(dadosTratados)

    res.status(200).json(dadosTratados);
};


module.exports = {
  buscarDados
};