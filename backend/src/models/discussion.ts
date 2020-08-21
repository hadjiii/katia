import mongoose, { Schema } from 'mongoose';
import { UserSchema } from './user';
import { MessageSchema } from './message';
import { IDiscussion } from '../interfaces/discussion';
import { type } from 'os';

const DiscussionSchema = new mongoose.Schema(
  {
    //_id: Schema.Types.ObjectId,
    name: String,
    creator: { type: Schema.Types.ObjectId, ref: 'User' },
    participants: [{ type: Schema.Types.ObjectId, ref: 'User' }],
    messages: [{ type: Schema.Types.ObjectId, ref: 'Message' }],
    medias: [{ type: Schema.Types.ObjectId, ref: 'Media' }],
    isGroup: { type: Boolean },
  },
  { timestamps: true },
);

export default mongoose.model<IDiscussion & mongoose.Document>('Discussion', DiscussionSchema);
