import mysql from 'mysql2' 

const pool = mysql.createPool({
    host: "localhost",
    user: "aluno",    
    database: "projetoPI",
    password: "sptech",
}).promise()

// export async function selectData(){
//     const [rows] = await pool.query("SELECT * from ")
//     return rows
// } 

export async function faturamento(){
    const [rows] = await pool.query("SELECT SUM(valores) as total from valoresData;")
    return rows;
}

export async function selectDados(){
    const [rows] = await pool.query("SELECT * from valoresData;")
    return rows;
}