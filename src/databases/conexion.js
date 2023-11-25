

import sql from "mssql";

const dbSettings={
    user: 'sa',
    password: 'miContrasena123',
    server: 'localhost',
    database: 'DB_MS',
    options:{
        encrypt: true,
        trustServerCertificate: true
    }
}

export async function getConnection(){
    try {
        const pool = await sql.connect(dbSettings);
        return pool;
    } catch (error) {
        console.log(error);
    }
}
