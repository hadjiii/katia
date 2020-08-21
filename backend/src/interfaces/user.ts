import { IMedia } from "./media";

export interface IUser {
  _id: string;
  username: string;
  password: string;
  avatar: IMedia;
}

export interface IUserInputDTO {
  username: string;
  password: string;
  avatar: string;
}
