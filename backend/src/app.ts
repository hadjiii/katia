import 'reflect-metadata';
import config from './config';
import http from 'http';
import express from 'express';
import socketIO from 'socket.io';
import Logger from './loaders/logger';

async function startServer() {
  const app = express();
  const server = http.createServer(app);

  const loaders = await import('./loaders');
  loaders.default({ expressApp: app });

  server.listen(config.port);
  Logger.info(`Server listening at port: ${config.port} 🚀`);

  const io = socketIO(server);
  io.on('connection', (socket) => {
    Logger.info(`New connection: ${socket.id}`);
  });
}

startServer();
