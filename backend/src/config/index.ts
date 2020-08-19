import dotenv from "dotenv";

export enum Env {
  Development = "development",
  Production = "production"
}

process.env.NODE_ENV = process.env.NODE_ENV || Env.Development;

const dotEnvFound = dotenv.config();

if (dotEnvFound.error) {
  throw new Error("Couldn't find .env file");
}

export default {
  port: parseInt(`${process.env.PORT}`, 10) || 3000,
  mongodb: {
    databaseURL: `${process.env.MONGODB_URI}`,
    username: `${process.env.MONGODB_USERNAME}`,
    password: `${process.env.MONGODB_PASSWORD}`
  },
  jwtSecret: `${process.env.JWT_SECRET}`,
  logs: {
    level: `${process.env.LOG_LEVEL}`
  }
};
