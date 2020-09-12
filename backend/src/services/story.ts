import { Service, Inject } from 'typedi';
import { Document, Model } from 'mongoose';
import { IUserInputDTO, IUser } from '../interfaces/user';
import { Logger } from 'winston';
import * as crud from '../utils/crud';
import * as jwt from '../utils/jwt';
import { MongoError } from 'mongodb';
import MediaService from './media';
import { IMedia } from '../interfaces/media';
import { IStoryInputDTO, IStory } from '../interfaces/story';

@Service()
export default class StoryService {
  constructor(
    @Inject('logger') private logger: Logger,
    @Inject('storyModel') private storyModel: Models.Story,
    private mediaService: MediaService,
  ) {}

  /**
   * @description Create a story
   * @param {IStoryInputDTO} userInputDTO
   * @return {Promise<Documents.Story>} The created story
   * @throws {MongoError} MongoError
   */
  public async create(input: IStoryInputDTO): Promise<Documents.Story> {
    let media: Documents.Media;
    let story: Documents.Story;

    try {
        media = await this.mediaService.create({owner: input.user, media: input.media});
      } catch (err) {
        throw new MongoError('Failed to create story media');
      }

    try {
      story = await crud.create<IStory>({user: input.user, media: media._id},
        this.storyModel
      );
    } catch (err) {
      throw new MongoError('Catch a Mongo error ==> ' + err);
    }

    if (!story) {
      throw new MongoError('Failed to create a story');
    }

    await story.populate('media').execPopulate();
    await media.populate('owner').execPopulate();

    return story;
  }

  /**
   * @description Find in a story
   * @param {{[filter: string]: any }} filters
   * @return {Promise<Documents.Story>} The found story
   * @throws {MongoError} MongoDb error
   */
  public async fetchOne(filters: { [filter: string]: any }): Promise<Documents.Story> {
    let story: Documents.Story;

    try {
      story = await crud.findOne<IStory>(filters, this.storyModel);
    } catch (err) {
      throw new MongoError(`Failed to find user, ${err}`);
    }

    if (!story) {
      throw new MongoError('Story not found');
    }

    return story;
  }

  /**
   * @description Find in all stories
   * @param {{[filter: string]: any }} filters
   * @return {Promise<Documents.Story[]>} An array of found stories
   * @throws {MongoError} MongoDb error
   */
  public async fetchAll(filters: { [filter: string]: any }): Promise<Documents.Story[]> {
    let story: Documents.Story[];

    try {
      story = await crud.findMany<IStory>(filters, this.storyModel);
    } catch (err) {
      throw new MongoError(`Failed to find stories, ${err}`);
    }

    return story;
  }

  /**
   * @description Update a story
   * @param {{[filter: string]: any }} filters
   * @param {{[filter: string]: any }} values
   * @return {Promise<IStory>} The updated story
   * @throws {MongoError} MongoDb error
   */
  public async updateOne(filters: { [filter: string]: any }, values: { [property: string]: any }): Promise<IStory> {
    let story: Documents.Story;

    try {
      story = await crud.updateOne<IStory>(filters, values, {new: true}, this.storyModel);
    } catch (err) {
      throw new MongoError(`Failed to update story, ${err}`);
    }

    if (!story) {
      throw new MongoError("Story not found");
    }

    return story;
  }

  /**
   * @description Remove a story
   * @param {{[filter: string]: any }} filters
   * @return {Promise<Documents.Story>} The removed story
   * @throws {MongoError} MongoDb error
   */
  public async deleteOne(filters: { [filter: string]: any }): Promise<Documents.Story> {
    let story: Documents.Story;

    try {
      story = await crud.deleteOne<IStory>(filters, this.storyModel);
    } catch (err) {
      throw new MongoError(`Failed to delete story, ${err}`);
    }

    if (!story) {
      throw new MongoError('Story not found');
    }

    return story;
  }
}
