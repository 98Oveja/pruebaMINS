import express from 'express';
import config from './config.js'
import personasRoutes from './routes/persona.routes.js';

const app = express();


app.set('port',config.port);

app.use(personasRoutes);

export default app;