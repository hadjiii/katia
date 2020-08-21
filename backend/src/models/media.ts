import mongoose, { Schema } from 'mongoose';
import { IMedia } from '../interfaces/media';

export const StorySchema = new mongoose.Schema(
  {
    //_id: Schema.Types.ObjectId,
    owner: { type: Schema.Types.ObjectId, ref: 'User' },
    name: String,
  },
  { timestamps: true },
);

export default mongoose.model<IMedia & mongoose.Document>('Media', StorySchema);
