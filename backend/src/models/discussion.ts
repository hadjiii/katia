import mongoose, { Schema, SchemaDefinition } from 'mongoose';
// import mongooseUniqueArrayPlugin from "mongoose-unique-array";
import { IDiscussion } from '../interfaces/discussion';

const options = {discriminatorKey: "type", timestamps: true}

// Discussion base schema
class DiscussionBaseSchema extends Schema {

  constructor(definition?: SchemaDefinition | undefined) {
    const keys = {
      messages: [{ type: Schema.Types.ObjectId, ref: 'Message' }],
      medias: [{ type: Schema.Types.ObjectId, ref: 'Media' }],
      isGroup: { type: Boolean },
      ...definition
    }

    super(keys, options);
  }
}

const DiscussionSchema = new DiscussionBaseSchema();

// Simple discussion schema
const SimpleDiscussionSchema = new DiscussionBaseSchema(
  {
    participant1: {type: Schema.Types.ObjectId, ref: 'User'},
    participant2: {type: Schema.Types.ObjectId, ref: 'User'}
  }
)

// For each simple group, the tuple (participant1, participant2) must me a unique compound index
SimpleDiscussionSchema.index({participant1: 1, participant2: 1}, {unique: true});

// Group discussion schema
const GroupDiscussionSchema = new DiscussionBaseSchema(
  {
    name: String,
    creator: {type: Schema.Types.ObjectId, ref: 'User'},
    participants: [{type: Schema.Types.ObjectId, ref: 'User'}]
  }
)

// Each group discussion must have a set of participants
//GroupDiscussionSchema.plugin(mongooseUniqueArrayPlugin)

export const Discussion = mongoose.model<IDiscussion & mongoose.Document>('Discussion', DiscussionSchema);
export const SimpleDiscussion = Discussion.discriminator<IDiscussion & mongoose.Document>('SimpleDiscussion', SimpleDiscussionSchema, 'simple_discussion');
export const GroupDiscussion = Discussion.discriminator<IDiscussion & mongoose.Document>('GroupDiscussion', GroupDiscussionSchema, 'group_discussion');
