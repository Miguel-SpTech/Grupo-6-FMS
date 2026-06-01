
var database = require("../database/config")
var router = require('../routes');

function buscarPorEmpresa(){
  var consultaSql = 
    `select * from vw_clientes_7dias;`
     return database.executar(consultaSql);
  }


module.exports = {
 buscarPorEmpresa
};