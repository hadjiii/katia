import { IUser } from './user';
import { IMedia, IMediaInputDTO } from './media';

export interface IStory {
  user: IUser;
  media: IMedia;
}

export interface IStoryInputDTO {
  user: string;
  media: string;
}
