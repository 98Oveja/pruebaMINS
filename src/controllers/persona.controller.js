import { getConnection } from "../databases/conexion.js";

export const getPersonas = async (req, res)=>{
    const pool = await getConnection();
    const result = await pool.request().query('exec SP_CONSULTAR_PERSONAS');
    console.log(result);
    res.json(result.recordset);
};
