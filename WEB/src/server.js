import app from "./app.js";
import { selectHistorico, last7days, lastMonth, selectDadosBarChart } from "./database.js";

app.get('/home', (req,res)=> res.sendFile("/home/usuario/Grupo-6-FMS/WEB/public/index.html"))

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

app.get('/api/selectHistorico', async (req,res)=>{
    const response = await selectHistorico()
    const data = response[0]
    res.json(data)
})