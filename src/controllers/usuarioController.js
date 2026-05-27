var usuarioModel = require("../models/usuarioModel");
var restauranteModel = require("../models/restauranteModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        // Buscar dados do restaurante associado
                        restauranteModel.buscarPorId(resultadoAutenticar[0].restauranteId)
                            .then((resultadoRestaurante) => {
                                if (resultadoRestaurante.length > 0) {
                                    res.json({
                                        id: resultadoAutenticar[0].id,
                                        email: resultadoAutenticar[0].email,
                                        nome: resultadoAutenticar[0].nome,
                                        cargo: resultadoAutenticar[0].cargo,
                                        restaurante: resultadoRestaurante[0]
                                    });
                                } else {
                                    res.status(404).json({ erro: "Restaurante não encontrado" });
                                }
                            })
                            .catch((erro) => {
                                console.log(erro);
                                res.status(500).json(erro.sqlMessage);
                            });
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Dados do usuário
    var nomeUsuario = req.body.nomeUsuarioServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var cargo = req.body.cargoServer || "Operador"; // Default para Operador

    // Dados do restaurante
    var razaoSocial = req.body.razaoSocialServer;
    var nomeFantasia = req.body.nomeFantasiaServer;
    var cnpj = req.body.cnpjServer;
    var quantMesas = req.body.quantMesasServer;

    // Validações
    if (!nomeUsuario) {
        res.status(400).send("Nome do usuário está undefined!");
    } else if (!email) {
        res.status(400).send("Email está undefined!");
    } else if (!senha) {
        res.status(400).send("Senha está undefined!");
    } else if (!razaoSocial) {
        res.status(400).send("Razão social está undefined!");
    } else if (!nomeFantasia) {
        res.status(400).send("Nome fantasia está undefined!");
    } else if (!cnpj) {
        res.status(400).send("CNPJ está undefined!");
    } else if (!quantMesas) {
        res.status(400).send("Quantidade de mesas está undefined!");
    } else {
        // Verificar se o email já existe
        usuarioModel.buscarPorEmail(email)
            .then((usuariosExistentes) => {
                if (usuariosExistentes.length > 0) {
                    res.status(409).send("Email já cadastrado no sistema!");
                    return;
                }

                // Verificar se o CNPJ já existe
                restauranteModel.buscarPorCnpj(cnpj)
                    .then((restaurantesExistentes) => {
                        if (restaurantesExistentes.length > 0) {
                            res.status(409).send("CNPJ já cadastrado no sistema!");
                            return;
                        }

                        // Cadastrar o restaurante primeiro
                        restauranteModel.cadastrar(razaoSocial, nomeFantasia, cnpj, quantMesas)
                            .then((resultadoRestaurante) => {
                                console.log("Restaurante cadastrado com sucesso:", resultadoRestaurante);
                                
                                // Obter o ID do restaurante inserido
                                restauranteModel.buscarPorCnpj(cnpj)
                                    .then((restaurante) => {
                                        const idRestaurante = restaurante[0].id;

                                        // Cadastrar o usuário com o ID do restaurante
                                        usuarioModel.cadastrar(nomeUsuario, email, senha, cargo, idRestaurante)
                                            .then((resultadoUsuario) => {
                                                console.log("Usuário cadastrado com sucesso:", resultadoUsuario);
                                                res.json({
                                                    mensagem: "Cadastro realizado com sucesso!",
                                                    usuario: {
                                                        email: email,
                                                        nome: nomeUsuario,
                                                        cargo: cargo
                                                    },
                                                    restaurante: {
                                                        razao_social: razaoSocial,
                                                        nome_fantasia: nomeFantasia,
                                                        cnpj: cnpj
                                                    }
                                                });
                                            })
                                            .catch((erro) => {
                                                console.log(erro);
                                                res.status(500).json({
                                                    erro: "Erro ao cadastrar usuário",
                                                    detalhes: erro.sqlMessage
                                                });
                                            });
                                    })
                                    .catch((erro) => {
                                        console.log(erro);
                                        res.status(500).json({
                                            erro: "Erro ao recuperar restaurante cadastrado",
                                            detalhes: erro.sqlMessage
                                        });
                                    });
                            })
                            .catch((erro) => {
                                console.log(erro);
                                res.status(500).json({
                                    erro: "Erro ao cadastrar restaurante",
                                    detalhes: erro.sqlMessage
                                });
                            });
                    })
                    .catch((erro) => {
                        console.log(erro);
                        res.status(500).json({
                            erro: "Erro ao verificar CNPJ",
                            detalhes: erro.sqlMessage
                        });
                    });
            })
            .catch((erro) => {
                console.log(erro);
                res.status(500).json({
                    erro: "Erro ao verificar email",
                    detalhes: erro.sqlMessage
                });
            });
    }
}

module.exports = {
    autenticar,
    cadastrar
}