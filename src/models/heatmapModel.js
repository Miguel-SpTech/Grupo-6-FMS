var database = require("../database/config");

function buscarHeatmap(idRestaurante) {
    const sql = `
        SELECT *
        FROM vw_heatmap_blocos
        WHERE idRestaurante =  ${idRestaurante};;
    `;

    return database.executar(sql, [idRestaurante]);
}

module.exports = {
    buscarHeatmap
};