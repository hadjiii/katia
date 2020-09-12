import { IUser } from './user';
import { IMessage } from './message';
import { IMedia } from './media';

export interface IDiscussion {
  _id: string;
  type: string;
  name?: string;
  participant1: IUser;
  participant2: IUser;
  participants?: [IUser];
  messages: [IMessage];
  medias: [IMedia];
}

export interface IDiscussionInputDTO {
  type: string;
}

export interface ISimpleDiscussionInputDTO extends IDiscussionInputDTO {
  participant1: string;
  participant2: string;
}

export interface IGroupDiscussionInputDTO extends IDiscussionInputDTO {
  name: string;
  creator: string;
  participants: string[];
}
