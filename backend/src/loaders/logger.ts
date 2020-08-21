import winston from 'winston';
import config, { Env } from '../config';

const transports = [];

if (process.env.NODE_ENV === Env.Development) {
  transports.push(new winston.transports.Console());
} else {
  const options = {
    format: winston.format.combine(winston.format.cli(), winston.format.splat()),
  };
  transports.push(new winston.transports.Console(options));
}

const LoggerInstance = winston.createLogger({
  level: config.logs.level,
  levels: winston.config.npm.levels,
  format: winston.format.combine(
    winston.format.timestamp({
      format: 'YYYY-MM-DD HH:mm:ss',
    }),
    winston.format.errors({ stack: true }),
    winston.format.splat(),
    winston.format.json(),
  ),
  transports,
});

export default LoggerInstance;
