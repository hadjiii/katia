import { IUser } from './user';
import { IMedia, IMediaInputDTO } from './media';
import { IDiscussion } from './discussion';

export interface IMessage {
  _id: string;
  discussion: IDiscussion;
  sender: IUser;
  content: {
    media?: IMedia,
    text?: string
  }
}

export interface IMessageInputDTO {
  discussion: string;
  sender: string;
  content: {
    media?: string
    text?: string
  }
}
