var kpiModel = require('../models/kpiModel');

async function buscarKpi(req, res){
    const empresa = req.params.empresa;
    try{
    const dadosKpiR = await kpiModel.buscarRotatividade(empresa);
    const dadosKpiF = await kpiModel.buscarFluxo(empresa);
    const dadosKpiO = await kpiModel.buscarOcupacao(empresa);

    res.status(200).json({
        rotatividade: dadosKpiR[0].rotatividade ? dadosKpiR[0].rotatividade : 0,
        fluxo: [dadosKpiF[0].atual ? dadosKpiF[0].atual : 0,
        dadosKpiF[0].ideal ? dadosKpiF[0].ideal : 0],
        ocupacao: dadosKpiO[0].ocupacao ? dadosKpiO[0].ocupacao : 0
    })
    }catch(error){
        console.log("Deu erro buscando as Kpis o erro foi: "+error)

        res.status(500).json({ 
            erro: "Erro ao buscar Kpis"
        })
    }
}

module.exports = {
    buscarKpi
};