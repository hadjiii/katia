import mongoose, { Schema } from 'mongoose';
import { IMessage } from '../interfaces/message';
import { UserSchema } from './user';

export const MessageSchema = new mongoose.Schema(
  {
    _id: Schema.Types.ObjectId,
    discussion: { type: Schema.Types.ObjectId, ref: 'Discussion' },
    sender: { type: Schema.Types.ObjectId, ref: 'User' },
    content: {
      type: String,
      required: true,
      trim: true,
    },
    media: { type: Schema.Types.ObjectId, ref: 'Media' },
  },
  { timestamps: true },
);

export default mongoose.model<IMessage & mongoose.Document>('Message', MessageSchema);
