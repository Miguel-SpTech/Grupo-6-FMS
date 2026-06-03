var usuarioModel = require("../models/usuarioModel");


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

                        // aquarioModel.buscarAquariosPorEmpresa(resultadoAutenticar[0].empresaId)
                        //     .then((resultadoAquarios) => {
                        //         if (resultadoAquarios.length > 0) {
                        //             res.json({
                        //                 id: resultadoAutenticar[0].id,
                        //                 email: resultadoAutenticar[0].email,
                        //                 nome: resultadoAutenticar[0].nome,
                        //                 senha: resultadoAutenticar[0].senha,
                        //                 aquarios: resultadoAquarios
                        //             });
                        //         } else {
                        //             res.status(204).json({ aquarios: [] });
                        //         }
                        //     })
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

 async function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeUsuarioServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var razaoSocial = req.body.razaoSocialServer;
    var nomeFantasia = req.body.nomeFantasiaServer;
    var qtdMesa = req.body.quantMesasServer;
    var cnpj = req.body.cnpjServer;
    var cep = req.body.cepServer;
    var complemento = req.body.complementoServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    // } else if (fkEmpresa == undefined) {
        // res.status(400).send("Sua empresa a vincular está undefined!");
    } else {
        console.log("vou tentar logar agora ")

    try {
        console.log("Iniciei o cadastrarRestaurante")
        await usuarioModel.cadatrarRestaurante(razaoSocial, nomeFantasia, cnpj, qtdMesa);
        console.log("Conclui o cadastrarRestaurante");

        console.log("Iniciei o selectIdRestaurante")
        const resultadoFkRestaurante = await usuarioModel.selectIdRestaurante(razaoSocial, cnpj);
        console.log("Conclui o selectIdRestaurante")

        const fkRestaurante = resultadoFkRestaurante[0].idRestaurante;
        console.log('separei a fkRestaurante: ' + fkRestaurante)

        console.log("Iniciei o cadastrarEndereco")
        await usuarioModel.cadastrarEndereco(cep, fkRestaurante);
        console.log("Conclui o cadastrarEndereco")

        console.log("Iniciei o cadastrarUsuario")
        await usuarioModel.cadastrarUsuario(nome, email, senha, fkRestaurante);
        console.log("Conclui o cadastrarUsuario")

    } catch (erro) {
        console.error("houve um problema ao tentar o cadastro", erro.message);
    }
    
    }
}

module.exports = {
    autenticar,
    cadastrar
}