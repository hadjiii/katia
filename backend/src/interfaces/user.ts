export interface IUser {
  _id: string;
  username: string;
  password: string;
  avatar: string;
}

export interface IUserInputDTO {
  username: string;
  password: string;
  avatar: string;
}
