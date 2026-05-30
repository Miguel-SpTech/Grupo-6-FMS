// models/colunaModel.js
const db = require('database/config'); 

exports.buscarPorEmpresa = async (idEmpresa) => {
  const [rows] = await db.query(
    `select *from vw_clientes_7dias;`
  )}
