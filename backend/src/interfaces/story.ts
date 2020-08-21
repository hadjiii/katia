import { IUser } from './user';
import { IMedia } from './media';

export interface IStory {
  _id: string;
  owner: IUser;
  media: [IMedia];
}

export interface IStoryInputDTO {
  userId: string;
  owner: IUser;
  media: [IMedia];
}
