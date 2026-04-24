import express from 'express'
import cors from 'cors'
const app = express()
const port = 3000

const __pathname = 

app.use(cors())
app.use(express.json())

app.use(express.static("./public"));

app.listen(port,()=> console.log("Servidor Iniciado!"))
export default app