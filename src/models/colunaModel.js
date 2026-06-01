
var db = require('database/config'); 
var router = require('../routes');

exports.buscarPorEmpresa = async (idEmpresa) => {
  const [rows] = await db.query(
    `select *from vw_clientes_7dias;`
  )}


module.exports = {
  router,
  express, colunaController, executar
};