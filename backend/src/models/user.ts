import mongoose, { Schema } from 'mongoose';
import { IUser } from '../interfaces/user';

export const UserSchema = new mongoose.Schema(
  {
    // _id: Schema.Types.ObjectId,
    username: {
      type: String,
      required: [true, 'Please enter a username'],
      lowercase: true,
      trim: true,
      minlength: [3, "The username's must contain 3 to 30 characters"],
      maxlength: [30, "The username's must contain 3 to 30 characters"],
      unique: true,
      index: true,
    },
    password: {
      type: String,
      required: true,
      minlength: [8, "The password's size contain 8 to 30 characters"],
      maxlength: [30, "The password's size contain 8 to 30 characters"],
    },
    avatar: { type: Schema.Types.ObjectId, ref: 'Media' },
    discussions: [{ type: Schema.Types.ObjectId, ref: 'Discussion' }],
  },
  { timestamps: true },
);

export default mongoose.model<IUser & mongoose.Document>('User', UserSchema);
