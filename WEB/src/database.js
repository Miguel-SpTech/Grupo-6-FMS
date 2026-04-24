import mysql from 'mysql2' 

const pool = mysql.createPool({
    host: "localhost",
    user: "victor",    
    database: "FMS",
    password: "123456",
}).promise()

export async function last7days(){
    const [rows] = await pool.query("SELECT COUNT(leitura) as total from Registros where data BETWEEN NOW() - INTERVAL 7 DAY AND NOW() and tipo_leitura = 'Entrada';")
    return rows;
}
export async function lastMonth(){
    const [rows] = await pool.query("SELECT COUNT(leitura) as total from Registros where data BETWEEN NOW() - INTERVAL 30 DAY AND NOW() and tipo_leitura = 'Entrada';")
    return rows;
}
export async function selectDadosBarChart(){
    const [rows] = await pool.query(`
        SELECT 
            DAYNAME(data) AS dia_semana, 
            COUNT(*) AS total 
        FROM Registros 
        WHERE data >= NOW() - INTERVAL 7 DAY 
        GROUP BY dia_semana
        ORDER BY FIELD(dia_semana, 
            'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'
        );
    `)
    return rows;
}


export async function selectHistorico(){
    const [rows] = await pool.query("SELECT COUNT(leitura) as total_dia from Registros where data >= NOW() - INTERVAL 1 day")
    return rows
}