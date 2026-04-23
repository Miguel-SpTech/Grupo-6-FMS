import app from "./app.js";
import { last7days, lastMonth, selectDadosBarChart } from "./database.js";

app.get('/home', (req,res)=> res.sendFile("/home/aluno/Vídeos/dashboard/public/index.html"))

app.get('/api/select7days',async (req,res)=>{ 
    const response = await last7days()
    const valores = response[0]
    res.json(valores.total)}    
)
app.get('/api/selectMonth',async (req,res)=>{ 
    const response = await lastMonth()
    const valores = response[0]
    res.json(valores.total)}    
)

app.get('/api/selectLabelsData', async (req,res)=>{
    const response = await selectDadosBarChart()
    const data = response
    console.log(data)
    res.json(data)
})