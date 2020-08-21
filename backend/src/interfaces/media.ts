import { IUser } from './user';

export interface IMedia {
  _id: string;
  owner: IUser;
  name: string;
}

export interface IMediaInputDTO {
  userId: string;
  owner: IUser;
  name: string;
}
