import app from "./app.js";
import { faturamento, selectDados } from "./database.js";

app.get('/home', (req,res)=> res.sendFile("/home/aluno/Vídeos/dashboard/public/index.html"))

app.get('/api/selectData',async (req,res)=>{ 
    const response = await faturamento()
    const valores = response[0]
    res.json(valores.total)}    
)

app.get('/api/selectLabelsData', async (req,res)=>{
    const response = await selectDados()
    const data = response
    res.json(data)
})