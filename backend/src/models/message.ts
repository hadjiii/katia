import mongoose, { Schema } from 'mongoose';
import { IMessage } from '../interfaces/message';

export const MessageSchema = new mongoose.Schema(
  {
    discussion: { type: Schema.Types.ObjectId, ref: 'Discussion' },
    sender: { type: Schema.Types.ObjectId, ref: 'User' },
    content: {
      media: { type: Schema.Types.ObjectId, ref: 'Media' },
      text: {type: String, trim: true, minlength: [1, "The message text must contain at 1 one character"] }
    }
  },
  { timestamps: true },
);

export default mongoose.model<IMessage & mongoose.Document>('Message', MessageSchema);