import { IUser } from './user';
import { IMedia } from './media';

export interface IMessage {
  _id: string;
  sender: IUser;
  recipient: IUser;
  content: string;
  media: IMedia;
}

export interface IMessageInputDTO {
  senderId: string;
  recipientId: string;
  content: string;
  media: IMedia;
}
