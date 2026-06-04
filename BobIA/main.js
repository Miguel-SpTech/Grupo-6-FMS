// importando os bibliotecas necessárias
const { GoogleGenAI } = require("@google/genai");
const express = require("express");
const path = require("path");
const contexto = `
Visão Geral

O FMS (Flow Management System) é um sistema de monitoramento de fluxo de clientes desenvolvido para restaurantes de rodízio de pizza.

Seu objetivo é coletar dados sobre a movimentação de pessoas dentro do estabelecimento através de sensores conectados a dispositivos Arduino e transformar essas informações em dashboards analíticos acessíveis por uma plataforma web.

O sistema auxilia gestores e profissionais de marketing a identificar períodos de baixa movimentação e tomar decisões baseadas em dados.

Problema

Muitos restaurantes de rodízio não possuem dados concretos sobre:

Quantidade de clientes por dia e horário;
Tempo de permanência dos clientes;
Ocupação dos diferentes setores do restaurante;
Efetividade de campanhas de marketing;
Padrões de movimentação ao longo da semana.

Sem essas informações, os gestores enfrentam dificuldades para:

Planejar promoções;
Otimizar recursos;
Reduzir desperdícios de insumos perecíveis;
Avaliar retorno sobre investimento (ROI) de ações publicitárias;
Manter uma ocupação consistente do restaurante.
Contexto de Negócio

O setor de rodízio trabalha com margem de lucro aproximada de 11%.

Problemas causados pela falta de monitoramento:

Salão vazio gera custos fixos sem retorno.
Desperdício de alimentos perecíveis.
Investimentos em marketing sem métricas claras.
Dificuldade em identificar horários de baixa demanda.

Existem soluções semelhantes no mercado, como sistemas de contagem de pessoas utilizando sensores infravermelhos, porém o FMS busca oferecer uma solução focada em análise de fluxo e suporte à tomada de decisão.

Objetivo Principal

Transformar dados de presença de clientes em informações estratégicas para:

Entender o comportamento dos consumidores.
Identificar períodos de baixa movimentação.
Auxiliar no planejamento de promoções.
Avaliar resultados de campanhas publicitárias.
Melhorar a gestão operacional do restaurante.
Funcionamento da Solução
Hardware

O sistema utiliza:

Arduino
Sensores ultrassônicos (HC-SR04)
Sensores instalados em diferentes setores do restaurante
Sensores posicionados no teto

Cada sensor opera de forma binária:

0 = Ausência de cliente
1 = Presença de cliente

Os dados são coletados continuamente e enviados ao sistema.

Coleta de Dados

O sistema registra:

Fluxo de Entrada
Quantidade de pessoas que entraram no restaurante.
Dia e horário da entrada.
Ocupação de Setores
Presença ou ausência de clientes em áreas específicas.
Tempo de Permanência

Estimativa de:

Tempo que o cliente permanece em determinado setor.
Tempo total de permanência no estabelecimento.
Plataforma Web

O usuário acessa os dados através de um website.

Estrutura Básica
Página Inicial

Apresentação do sistema.

Página de Login

Acesso restrito para administradores.

Dashboard

Visualização dos dados coletados.

Funcionalidades do Dashboard
Gráficos Analíticos

Exibição de:

Clientes por dia.
Clientes por hora.
Clientes por semana.
Clientes por mês.
Clientes por trimestre.
Clientes por ano.
Monitoramento em Tempo Real
Gráfico de lotação.
Atualização com atraso máximo de 5 minutos.
Mapas de Calor

Visualização de:

Áreas mais frequentadas.
Áreas menos frequentadas.
Tempo médio de permanência por setor.
Alertas

Geração automática de alertas relacionados ao fluxo:

Exemplos:

Movimento baixo.
Movimento normal.
Movimento elevado.

Os alertas podem ser exibidos:

Na interface web.
Por e-mail.
Benefícios Esperados

Após a implementação do FMS, o restaurante poderá:

Conhecer com precisão seu fluxo de clientes.
Identificar horários críticos.
Planejar promoções com maior embasamento.
Reduzir desperdícios.
Avaliar impactos de campanhas de marketing.
Tomar decisões mais assertivas.
Banco de Dados

O sistema deve armazenar:

Usuários
Dados de login.
Credenciais.
Empresas
Dados dos restaurantes cadastrados.
Sensores
Cadastro dos sensores.
Localização/setor do sensor.
Blocos/Setores
Divisão física do restaurante.
Eventos de Sensores
Registros de presença e ausência.
Alertas
Alertas gerados pelo sistema.
Logs
Histórico completo das operações.
Requisitos Funcionais
RF01

Monitorar ocupação dos setores do restaurante.

RF02

Registrar presença (1) e ausência (0) através dos sensores.

RF03

Contabilizar quantidade de clientes por dia e horário.

RF04

Estimar tempo de permanência dos clientes.

RF05

Gerar dashboards e gráficos analíticos.

RF06

Gerar mapa de calor de ocupação.

RF07

Possuir sistema de login restrito.

RF08

Cadastrar usuários, empresas e sensores.

RF09

Emitir alertas de movimentação.

RF10

Exibir lotação em tempo real com atraso máximo de 5 minutos.

RF11

Registrar logs de todas as operações.

Escopo do Projeto
Itens Incluídos
Plataforma Web
Dashboard interativo.
Monitoramento contínuo.
Gráficos analíticos.
Hardware
Instalação inicial dos Arduinos.
Configuração dos sensores.
Manutenção preventiva e corretiva contratada.
Software
Atualizações da plataforma.
Correção de falhas.
Melhorias de usabilidade.
Alertas
Alertas automáticos por sistema ou e-mail.
Itens Excluídos

O FMS NÃO:

Cria campanhas de marketing.
Faz consultoria de marketing.
Executa promoções.
Controla ativamente o fluxo de pessoas.
Sugere automaticamente estratégias comerciais.
Integra com sistemas de terceiros sem contrato adicional.
Cobre danos causados por mau uso ou vandalismo.
Garante aumento de faturamento ou ROI.

O sistema atua exclusivamente como ferramenta de monitoramento e suporte à tomada de decisão.

Tecnologias Principais
Hardware
Arduino
Sensor ultrassônico HC-SR04
Software
Aplicação Web
Sistema de Login
Dashboard Analítico
Banco de Dados Relacional`

// carregando as variáveis de ambiente do projeto do arquivo .env
require("dotenv").config();

// configurando o servidor express
const app = express();
const PORTA_SERVIDOR = process.env.PORTA;

// configurando o gemini (IA)
const chatIA = new GoogleGenAI({ apiKey: process.env.MINHA_CHAVE });

// configurando o servidor para receber requisições JSON
app.use(express.json());

// configurando o servidor para servir arquivos estáticos
app.use(express.static(path.join(__dirname, "public")));

// configurando CORS
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
    next();
});

// inicializando o servidor
app.listen(PORTA_SERVIDOR, () => {
    console.info(
        `
        ######                ###    #    
        #     #  ####  #####   #    # #   
        #     # #    # #    #  #   #   #  
        ######  #    # #####   #  #     # 
        #     # #    # #    #  #  ####### 
        #     # #    # #    #  #  #     # 
        ######   ####  #####  ### #     # 
        `
    );
    console.info(`A API BobIA iniciada, acesse http://localhost:${PORTA_SERVIDOR}`);
});

// rota para receber perguntas e gerar respostas
app.post("/perguntar", async (req, res) => {
    const pergunta = req.body.pergunta;

    try {
        const resultado = await gerarResposta(pergunta);
        res.json({ resultado });
    } catch (error) {
        res.status(500).json({ error: 'Erro interno do servidor' });
    }

});

// função para gerar respostas usando o gemini
async function gerarResposta(mensagem) {

    try {
        // gerando conteúdo com base na pergunta
        const modeloIA = chatIA.models.generateContent({
            model: "gemini-2.5-flash",
            contents: `Em um paragráfo responda: ${mensagem} com o seguinte contexto: ${contexto}`

        });
        const resposta = (await modeloIA).text;
        const tokens = (await modeloIA).usageMetadata;

        console.log(resposta);
        console.log("Uso de Tokens:", tokens);

        return resposta;
    } catch (error) {
        console.error(error);
        throw error;
    }
}
