import express from 'express'
const port = 3000
const app = express()
app.use(express.static('WEB'))

app.get('/home', (req,res)=> res.sendFile('/home/aluno/Downloads/Grupo-6-FMS/WEB/Estatico.html'))

app.listen(port, ()=> console.log("Servidor Rodando!"))