import { Service, Inject } from 'typedi';
import { Logger } from 'winston';
import * as crud from '../utils/crud';
import { MongoError } from 'mongodb';
import MediaService from './media';
import { IMessageInputDTO } from '../interfaces/message';

@Service()
export default class MessageService {
  constructor(
    @Inject('logger') private logger: Logger,
    @Inject('messageModel') private messageModel: Models.Message,
    private mediaService: MediaService
  ) {}

  /**
   * @description Create a message
   * @param {IUserInputDTO} userInputDTO
   * @return {Promise<Documents.Message>} The created user and a JWT token
   * @throws {MongoError} MongoError
   */
  public async create(input: IMessageInputDTO): Promise<Documents.Message> {
    let addedMedia: Documents.Media;
    let addedMessage: Documents.Message;

    let {content, ...message} = input;

    if(!(content.media || content.text)) {
      throw new MongoError('A message must contain a media or a text');
    }

    if(content.media) {
      try {
        
          addedMedia = await this.mediaService.create({name: content.media, owner: message.sender});
      
      } catch (err) {
        throw new MongoError('Failed to create message media');
      }
    }

    try {
      addedMessage = await crud.create<Documents.Message>(
        message,
        this.messageModel,
      );
    } catch (err) {
      throw new MongoError('Catch a Mongo error ==> ' + err);
    }

    if (!addedMessage) {
      throw new MongoError('Failed to create a message');
    }

    // if(addedMedia) {
      //await addedMedia.populate('owner').execPopulate();
      await addedMessage.populate('media').execPopulate();
      return addedMessage;
    // }
  }

  /**
   * @description Fetch a message by id
   * @param {string} Message id
   * @return {Promise<Documents.Message>} The found message
   * @throws {MongoError} MongoDb error
   */
  public async fetchOneById(id: string): Promise<Documents.Message> {
    let message: Documents.Message;

    try {
      message = await crud.findOne<Documents.Message>({ _id: id }, this.messageModel);
    } catch (err) {
      throw new MongoError(`Failed to find message by id, ${err}`);
    }

    if (!message) {
      throw new MongoError('Message not found');
    }

    return message;
  }

  /**
   * @description Fetch a messages by discussion id
   * @param {string} Discussion id
   * @return {Promise<Documents.Message[]>} An array of messages
   * @throws {MongoError} MongoDb error
   */
  public async fetchByDiscussionId(discussionId: string): Promise<Documents.Message[]> {
    let messages: Documents.Message[];

    try {
      messages = await crud.findMany<Documents.Message>({ discussion: discussionId }, this.messageModel);
    } catch (err) {
      throw new MongoError(`Failed to find message by id, ${err}`);
    }

    return messages;
  }

  /**
   * @description Fetch a messages by discussion id
   * @param {string} Discussion id
   * @return {Promise<Documents.Message>} An array of messages
   * @throws {MongoError} MongoDb error
   */
  public async deleteById(id: string): Promise<Documents.Message> {
    let message: Documents.Message;

    try {
      message = await crud.deleteOne<Documents.Message>({ _id: id }, this.messageModel);
    } catch (err) {
      throw new MongoError(`Failed to delete message by id, ${err}`);
    }

    if(!message) {
      throw new MongoError(`Message not found`);
    }

    return message;
  }

  /**
   * @description Fetch a messages by discussion id
   * @param {string} Discussion id
   * @return {Promise<Documents.Message[]>} An array of messages
   * @throws {MongoError} MongoDb error
   */
  public async deleteByDiscussionId(id: string): Promise<Documents.Message[]> {
    let messages: Documents.Message[];

    try {
      messages = await crud.deleteMany<Documents.Message>({ discussion: id }, this.messageModel);
    } catch (err) {
      throw new MongoError(`Failed to delete message by discussion id, ${err}`);
    }

    if(!messages) {
      throw new MongoError(`Discussion not found`);
    }

    return messages;
  }
}
