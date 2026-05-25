var database = require("../database/config")
var bcrypt = require("bcryptjs");

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function autenticar(): ", email)
    
    // Query corrigida para usar a tabela Usuario real do FMS
    var instrucaoSql = `
        SELECT 
            idUsuario as id, 
            nome, 
            email, 
            cargo,
            fkRestaurante as restauranteId
        FROM Usuario 
        WHERE email = '${email}';
    `;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    
    return new Promise((resolve, reject) => {
        database.executar(instrucaoSql)
            .then((resultados) => {
                if (resultados.length === 1) {
                    // Comparar a senha com hash
                    const usuario = resultados[0];
                    // Para compatibilidade, verificar se a senha é hash ou texto plano
                    if (usuario.senha && usuario.senha.startsWith('$2')) {
                        // É hash bcrypt
                        bcrypt.compare(senha, usuario.senha, (err, isMatch) => {
                            if (err) {
                                reject(err);
                            } else if (isMatch) {
                                resolve([usuario]);
                            } else {
                                resolve([]);
                            }
                        });
                    } else {
                        // Compatibilidade com senhas antigas em texto plano
                        if (usuario.senha === senha) {
                            resolve([usuario]);
                        } else {
                            resolve([]);
                        }
                    }
                } else {
                    resolve(resultados);
                }
            })
            .catch(reject);
    });
}

function cadastrar(nome, email, senha, cargo, fkRestaurante) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, cargo);
    
    return new Promise((resolve, reject) => {
        // Hash da senha com bcrypt
        bcrypt.hash(senha, 10, (err, hash) => {
            if (err) {
                reject(err);
                return;
            }
            
            // Query corrigida para usar a tabela Usuario real do FMS
            var instrucaoSql = `
                INSERT INTO Usuario (nome, email, senha, cargo, fkRestaurante) 
                VALUES ('${nome}', '${email}', '${hash}', '${cargo}', ${fkRestaurante});
            `;
            
            console.log("Executando a instrução SQL: \n" + instrucaoSql);
            database.executar(instrucaoSql)
                .then(resolve)
                .catch(reject);
        });
    });
}

function buscarPorEmail(email) {
    console.log("Buscando usuário por email: ", email);
    
    var instrucaoSql = `
        SELECT 
            idUsuario as id, 
            nome, 
            email, 
            cargo,
            fkRestaurante as restauranteId
        FROM Usuario 
        WHERE email = '${email}';
    `;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarPorId(id) {
    console.log("Buscando usuário por ID: ", id);
    
    var instrucaoSql = `
        SELECT 
            idUsuario as id, 
            nome, 
            email, 
            cargo,
            fkRestaurante as restauranteId
        FROM Usuario 
        WHERE idUsuario = ${id};
    `;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar,
    buscarPorEmail,
    buscarPorId
};
