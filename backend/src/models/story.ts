import mongoose, { Schema } from 'mongoose';
import { IStory } from '../interfaces/story';

export const StorySchema = new mongoose.Schema(
  {
    _id: Schema.Types.ObjectId,
    owner: { type: Schema.Types.ObjectId, ref: 'User' },
    media: { type: Schema.Types.ObjectId, ref: 'Media' },
  },
  { timestamps: true },
);

export default mongoose.model<IStory & mongoose.Document>('Story', StorySchema);
