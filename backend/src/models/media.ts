import mongoose, { Schema } from 'mongoose';
import { IMedia } from '../interfaces/media';

export const MediaSchema = new mongoose.Schema(
  {
    owner: { type: Schema.Types.ObjectId, ref: 'User' },
    name: String,
  },
  { timestamps: true },
);

export default mongoose.model<IMedia & mongoose.Document>('Media', MediaSchema);
