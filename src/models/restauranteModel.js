var database = require("../database/config")

function buscarPorCnpj(cnpj) {
    console.log("Buscando restaurante por CNPJ: ", cnpj);
    
    var instrucaoSql = `
        SELECT 
            idRestaurante as id,
            razao_social,
            nome_fantasia,
            cnpj,
            status,
            quantmesa
        FROM Restaurante 
        WHERE cnpj = '${cnpj}';
    `;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarPorId(id) {
    console.log("Buscando restaurante por ID: ", id);
    
    var instrucaoSql = `
        SELECT 
            idRestaurante as id,
            razao_social,
            nome_fantasia,
            cnpj,
            status,
            quantmesa
        FROM Restaurante 
        WHERE idRestaurante = ${id};
    `;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listar() {
    console.log("Listando todos os restaurantes");
    
    var instrucaoSql = `
        SELECT 
            idRestaurante as id,
            razao_social,
            nome_fantasia,
            cnpj,
            status,
            quantmesa
        FROM Restaurante;
    `;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrar(razao_social, nome_fantasia, cnpj, quantmesa) {
    console.log("ACESSEI O RESTAURANTE MODEL - cadastrar():", razao_social, cnpj);
    
    var instrucaoSql = `
        INSERT INTO Restaurante (razao_social, nome_fantasia, cnpj, status, quantmesa) 
        VALUES ('${razao_social}', '${nome_fantasia}', '${cnpj}', 'Pendente', ${quantmesa});
    `;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}





module.exports = {
    buscarPorCnpj,
    buscarPorId,
    listar,
    cadastrar
    
};
