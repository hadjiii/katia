import express, {Request, Response, NextFunction} from 'express';
import bodyParser from 'body-parser';
import config from '../config';
import routes from '../api/rest';
import cors from 'cors';

export default ({ app }: { app: express.Application }) => {
  app.use(cors());
  
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({ extended: true }));

  // Configures API routes prefix
  app.use(config.api.prefix, routes());

  /**
   * Creates an error with status 404 when route not found and forwards it to the next middleware
   */
  app.use((req: Request, res: Response, next: NextFunction) => {
    const err = new Error('Not found');
    err['status'] = 404;
    next(err);
  })

  /**
   * Handles authorization error
   * Forwards error if not unauthorized error
   */
  app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    if(err.name === "Unauthorized") {
      res.send({message: err.message}).status(401).end();
      return;
    }
    next(err);
  })

  /**
   * Handles all errors but authorization error
   * Sends error to the client
   */
  app.use((err: Error, req: Request, res: Response) => {
    res.status(err.status || 500);
    res.send({message: err.status ? err.message: 'Internal error'}).end();
  })
};
