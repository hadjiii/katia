import { Model, Document } from 'mongoose';
import { IUser } from '../interfaces/user';
import { IDiscussion } from '../interfaces/discussion';
import { IMessage } from '../interfaces/message';
import { IStory } from '../interfaces/story';
import { IMedia } from '../interfaces/media';

declare global {
  namespace Models {
    export type User = Model<Documents.User>;
    export type Discussion = Model<Documents.Discussion>;
    export type Message = Model<Documents.Message>;
    export type Story = Model<Documents.Story>;
    export type Media = Model<Documents.Media>;
  }

  namespace Documents {
    export type User = IUser & Document;
    export type Discussion = IDiscussion & Document;
    export type Message = IMessage & Document;
    export type Story = IStory & Document;
    export type Media = IMedia & Document;
  }
}
