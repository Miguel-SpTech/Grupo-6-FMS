import mysql from 'mysql2' 

const pool = mysql.createPool({
    host: "localhost",
    user: "aluno",    
    database: "FMS",
    password: "sptech",
}).promise()

// export async function selectData(){
//     const [rows] = await pool.query("SELECT * from ")
//     return rows
// } 

export async function last7days(){
    const [rows] = await pool.query("SELECT COUNT(leitura) as total from registros where data BETWEEN NOW() - INTERVAL 7 DAY AND NOW() and tipo_leitura = 'Entrada';")
    return rows;
}
export async function lastMonth(){
    const [rows] = await pool.query("SELECT COUNT(leitura) as total from registros where data BETWEEN NOW() - INTERVAL 30 DAY AND NOW() and tipo_leitura = 'Entrada';")
    return rows;
}

export async function selectDadosBarChart(){
    const [rows] = await pool.query("SELECT DAYNAME(data) AS dia_semana, COUNT(*) AS total FROM registros WHERE data >= NOW() - INTERVAL 7 DAY GROUP BY DAYNAME(data) ORDER BY FIELD(DAYNAME(data), 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');")
    return rows;
}