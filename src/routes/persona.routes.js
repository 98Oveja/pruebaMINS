
import { Router } from "express";
import { getPersonas } from "../controllers/persona.controller.js";

const router = Router();

router.get('/personas',getPersonas);
// router.post('/personas',getPersonas);
// router.put('/pesonas/:id',getPersonas);
// router.delete('/personas/:id',getPersonas);


export default router

