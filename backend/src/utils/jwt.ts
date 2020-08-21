import { IUser } from '../interfaces/user';
import jwt from 'jsonwebtoken';
import config from '../config';

export function generateToken(user: IUser): string {
  const today = new Date();
  const expiration = new Date(today);
  expiration.setDate(today.getDate() + 60);

  return jwt.sign(
    {
      _id: user._id,
      username: user.username,
      expiration: expiration.getTime() / 1000,
    },
    config.jwtSecret,
  );
}
