import express from 'express';
import mongooseLoader from './mongoose';
import expressLoader from './express';
import Logger from './logger';
import Container from 'typedi';
import config from '../config';

export default async ({ expressApp }: { expressApp: express.Application }) => {
  const db = await mongooseLoader(config.mongodb.databaseURL);
  Logger.silly('Connection established to MongoDB');

  const UserModel = await import("../models/user")
  const MediaModel = await import("../models/media")
  const DiscussionModel = await import("../models/discussion")
  const StoryModel = await import("../models/story")
  const MessageModel = await import("../models/message")

  Container.set('userModel', UserModel.default);
  Container.set('mediaModel', MediaModel.default);
  Container.set('discussionModel', DiscussionModel.Discussion);
  Container.set('storyModel', StoryModel.default);
  Container.set('messageModel', MessageModel.default);

  Container.set('logger', Logger);

  await expressLoader({ app: expressApp });
};
