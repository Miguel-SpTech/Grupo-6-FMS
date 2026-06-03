var database = require("../database/config")

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT id, nome, email, fk_empresa as empresaId FROM usuario WHERE email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(nome, email, senha, razao_social, nome_fantasia, quantMesa, cnpj, cep, complemento) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    cadatrarRestaurante(razao_social, nome_fantasia, cnpj, status, quantMesa)

    cadastrarEndereco(cep, fkRestaurante)
    cadastrarUsuario(nome, email, senha, fkRestaurante, fkUsuario)

    
}

function cadatrarRestaurante(razao_social, nome_fantasia, cnpj, quantMesa) {
    var instrucaoSql_insertRestaurante = `
        INSERT INTO Restaurante (razao_social, nome_fantasia, cnpj, status, quantmesa) VALUES ('${razao_social}','${nome_fantasia}','${cnpj}',DEFAULT,${quantMesa});
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql_insertRestaurante);

    return database.executar(instrucaoSql_insertRestaurante);
}

function selectIdRestaurante(razao_social, cnpj) {

    var instrucaoSql_selectIdRestaurante = `
        SELECT idRestaurante FROM Restaurante WHERE razao_social = '${razao_social}' AND cnpj = '${cnpj}';
    `

    console.log("Executando a instrução SQL: \n" + instrucaoSql_selectIdRestaurante);

    return database.executar(instrucaoSql_selectIdRestaurante);
}

function cadastrarEndereco(cep,complemento, fkRestaurante) {
    var instrucaoSql_insertEndereco = `
        INSERT INTO Endereco (cep, complemento,fkRestaurante) VALUES ('${cep}', '${complemento}', '${fkRestaurante}');
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql_insertEndereco);
    return database.executar(instrucaoSql_insertEndereco);
}

function cadastrarUsuario(nome, email, senha, fkRestaurante) {
    var instrucaoSql_insertUsuario = `
        INSERT INTO Usuario (nome, email, senha, cargo, fkRestaurante) VALUES ('${nome}', '${email}', '${senha}', 'Administrador', ${fkRestaurante});
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql_insertUsuario);

    return  database.executar(instrucaoSql_insertUsuario);
}

module.exports = {
    autenticar,
    cadatrarRestaurante,
    cadastrarEndereco,
    cadastrarUsuario,
    selectIdRestaurante
};