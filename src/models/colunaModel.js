
var database = require("../database/config")
var router = require('../routes');

function buscarPorEmpresa(idEmpresa){
  var consultaSql = 
    `select * from vw_clientes_7dias WHERE idRestaurante = ${idEmpresa};`
    console.log("executando a instrução mysql de buscar dados dos yultimos 7 dias" + consultaSql)
     return database.executar(consultaSql);
  }


module.exports = {
 buscarPorEmpresa
};