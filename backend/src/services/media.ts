import { Service, Inject } from 'typedi';
import { Logger } from 'winston';
import { IMedia } from '../interfaces/media';
import * as crud from '../utils/crud';
import { MongoError } from 'mongodb';

@Service()
export default class MediaService {
  constructor(@Inject('logger') private logger: Logger,
  @Inject('mediaModel') private mediaModel: Models.Media,  @Inject('userModel') private userModel: Models.User) {}
  
  /**
   * @description Create a media
   * @param {{[filter: string]: any}} filters
   * @return {Promise<Documents.Media>} The created media
   * @throws {MongoError} MongoError
   */
  public async create(values: { [filter: string]: any }): Promise<Documents.Media> {
    let media: Documents.Media
    
    try {
      media = await crud.create<IMedia>(values, this.mediaModel);
    }
    catch(err) {
      throw new MongoError("Media creation error, " + err)
    }

    if (!media) {
      throw new MongoError('Media not created');
    }

    await media.populate('owner').execPopulate();

    return media;
  }

  /**
   * @description Find a media that matches the given filters
   * @param {{[filter: string]: any}} filters
   * @return {Promise<Documents.Media>} The found media
   * @throws {MongoError} MongoError
   */
  public async fetchOne(filters: { [filter: string]: any }): Promise<Documents.Media> {
    let media: Documents.Media

    try{
      media = await crud.findOne<IMedia>(filters, this.mediaModel);
    }
    catch(err) {
      throw new MongoError("Failed to fetch media, " + err);
    }

    if (!media) {
      throw new MongoError('Media not found');
    }

    return media;
  }

  /**
   * @description Find medias that match the given filters
   * @param {{[filter: string]: any}} filters
   * @return {Promise<Documents.Media>} An array of found medias
   * @throws {MongoError} MongoError
   */
  public async fetchAll(filters: { [filter: string]: any }): Promise<Documents.Media[]> {
    const medias = await crud.findMany<IMedia>(filters, this.mediaModel);
    return medias;
  }

  /**
   * @description Update a media that matches the given filters
   * @param {{[filter: string]: any}} filters
   * @param {{[filter: string]: any}} values New values
   * @return {Promise<Documents.Media>} An array of found medias
   * @throws {MongoError} MongoError
   */
  public async updateOne(filters: { [filter: string]: any }, values: { [property: string]: any }) {
    const media = await crud.updateOne<IMedia>(filters, values, {$new: true}, this.mediaModel);

    if (!media) {
      throw new MongoError('User not updated');
    }
    return media;
  }

  /**
   * @description Delete a media that matches the given filters
   * @param {{[filter: string]: any}} filters
   * @return {Promise<Documents.Media>} The removed media
   * @throws {MongoError} MongoError
   */
  public async deleteOne(filters: { [filter: string]: any }): Promise<Documents.Media> {
    let media: Documents.Media

    try{
      media = await crud.deleteOne<IMedia>(filters, this.mediaModel);
    }
    catch(err) {
      throw new MongoError("Failed to fetch media, " + err);
    }

    if (!media) {
      throw new MongoError('Media not found');
    }
    
    return media;
  }
}
