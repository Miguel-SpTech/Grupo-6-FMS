var heatmapModel = require("../models/heatmapModel");

async function buscarHeatmap(req, res) {
    const id = req.params.id;

    try {
        const dados = await heatmapModel.buscarHeatmap(id);
        res.status(200).json(dados);
    } catch (error) {
        console.log(error);
        res.status(500).send("Erro ao buscar heatmap");
    }
}

module.exports = {
    buscarHeatmap
};