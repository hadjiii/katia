import { IUser } from './user';
import { IMessage } from './message';
import { IMedia } from './media';

export interface IDiscussion {
  _id: string;
  name: string;
  creator: IUser;
  participants: [IUser];
  messages: [IMessage];
  medias: [IMedia];
  isGroup: boolean;
}

export interface IDiscussionInputDTO {
  name: string;
  creator: IUser;
  participants: [IUser];
  messages: [IMessage];
  medias: [IMedia];
  isGroup: boolean;
}
