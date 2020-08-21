import express from 'express';
import bodyParser from 'body-parser';

export default ({ app }: { app: express.Application }) => {
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({ extended: true }));
};
