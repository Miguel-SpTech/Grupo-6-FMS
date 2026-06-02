var database = require("../database/config")

async function buscarRotatividade(empresa){
console.log("Cheguei no model de buscar a kpi de: rotatividade");
    var instrucaoSql = `
        SELECT rotacao_mesa as rotatividade from
        vw_rotacao_mesa WHERE idRestaurante = ${empresa}
                `;
    
    return database.executar(instrucaoSql);
}

async function buscarFluxo(empresa){
console.log("Cheguei no model de buscar a kpi de: fluxo ");
    var instrucaoSql = `
        SELECT fluxo_atual_7dias as atual, fluxo_ideal_7dias as ideal from
        vw_fluxo_7dias WHERE idRestaurante = ${empresa}
                `;
    
    return database.executar(instrucaoSql);
}

async function buscarOcupacao(empresa){
console.log("Cheguei no model de buscar a kpi de: ocupacao ");
    var instrucaoSql = `
        SELECT percentual_ocupacao as ocupacao from
        vw_ocupacao_restaurante WHERE idRestaurante = ${empresa}
                `;
    
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarRotatividade,
    buscarFluxo,
    buscarOcupacao
};