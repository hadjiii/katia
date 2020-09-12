import { Service, Inject } from 'typedi';
import { Logger } from 'winston';
import { IDiscussion, IDiscussionInputDTO} from '../interfaces/discussion';
import * as crud from '../utils/crud';
import { IUser } from '../interfaces/user';
import { MongoError } from 'mongodb';
import { Types } from 'mongoose';

@Service()
export default class DiscussionService {
  constructor(
    @Inject('logger') private logger: Logger,
    @Inject('discussionModel')
    private discussionModel: Models.Discussion
  ) {}

  /**
   * @description Create a discussion
   * @param {T extends IDiscussionInputDTO} input
   * @return {Promise<Documents.Discussion>} The created discussion
   * @throws {MongoError} MongoError
   */
  public async create<T extends IDiscussionInputDTO>(input: T) {
    let discussion: Documents.Discussion;

    try {
      discussion = await crud.create<IDiscussion>(input, this.discussionModel);
    } catch (err) {
      throw new MongoError('Failed to create a new discussion ===>' + err);
    }

    if (!discussion) {
      throw new MongoError('Failed to create a new discussion ===>');
    }

    await discussion.populate('participant1');
    await discussion.populate('participant2');

    return discussion;
  }

  /**
   * @description Find a discussion that matches the given filters
   * @param {{[filter: string]: any}} filters
   * @return {Promise<Documents.Discussion>} The found discussion
   * @throws {MongoError} MongoError
   */
  public async fetchOne(filters: {[filter: string]: any}) {
    let discussion: Documents.Discussion;

    try {
      discussion = await crud.findOne<IDiscussion>(filters, this.discussionModel);
    } catch (err) {
      throw new MongoError('Failed to find a discussion ===>' + err);
    }

    if (!discussion) {
      throw new MongoError('Failed to find a discussion ===>');
    }

    return discussion;
  }

   /**
   * @description Find discussions where the given user is part of
   * @param {string} userId The id of the user
   * @return {Promise<Documents.Discussion[]>} An array of found discussions
   * @throws {MongoError} MongoError
   */
  public async fetchAllForUser(userId: string) {
    try {
      const filters = {
       $or: [
          {participants: {$in: [Types.ObjectId(userId)]}},
          {participant1: Types.ObjectId(userId)},
          {participant2: Types.ObjectId(userId)}
        ]
      }
      const discussions = await crud.findMany<IDiscussion>(filters, this.discussionModel);
      
      return discussions;
    } catch (err) {
      throw new MongoError('Failed to find a discussion ===>' + err);
    }
  }

  /**
   * @description Find discussions that match the given filters
   * @param {{[filter: string]: any}} filters
   * @return {Promise<Documents.Discussion[]>} An array of found discussions
   * @throws {MongoError} MongoError
   */
  public async fetchAll(filters: {[filter: string]: any}) {
    let discussions: Documents.Discussion[];

    try {
      discussions = await crud.findMany<IDiscussion>(filters, this.discussionModel);
    } catch (err) {
      throw new MongoError('Failed to find a discussion ===>' + err);
    }

    if (!discussions) {
      throw new MongoError('Failed to find a discussion ===>');
    }

    return discussions;
  }

  /**
   * @description Find a discussions by id
   * @param {id: string} The id of the discussion
   * @return {Promise<Documents.Discussion>} The found discussion
   * @throws {MongoError} MongoError
   */
  public async fetchById(id: string) {
    let discussion: Documents.Discussion;

    try{
     discussion = await crud.findOne<IDiscussion>({ _id: id }, this.discussionModel);
    }
    catch(err) {
      throw new MongoError("Failed to find discussion " + err);
    }

    if (!discussion) {
      throw new MongoError("The discussion doesn't exist");
    }

    return discussion;
  }

  public async fetchAllByUsername(username: string) {
    const discussion = await crud.findMany<IDiscussion>({ username: username }, this.discussionModel);

    if (!discussion) {
      throw new Error("Failed to fetch user's discussions");
    }

    return discussion;
  }

  public async fetchParticipants(discussionId: string) {
    try {
      const participants = await crud.findMany<IUser>({ _id: discussionId }, this.discussionModel);
    } catch (err) {
      throw new Error('Failed to create a new discussion');
    }
  }

  public async addParticipants(discussionId: string, participants: [string]) {
    throw new Error('Not implemented');
  }

  public async updateNameById(id: string, newName: string) {
    let discussion: Documents.Discussion;

    try {
      discussion = await crud.updateOne<Documents.Discussion>({_id: id, type: 'group_discussion'}, {name: newName}, {new: true}, this.discussionModel);
    }
    catch(err) {
      throw new MongoError("Failed to update discussion name by id " + err);
    }

    if(!discussion) {
      throw new MongoError("Discussion not found");
    }

    if(discussion.type !== 'group_discussion') {
      throw new MongoError("This discussion has no name");
    }

    return discussion;
  }

  public async deleteById(id: string) {
    let discussion: Documents.Discussion;

    try {
      discussion = await crud.deleteOne<Documents.Discussion>({_id: id}, this.discussionModel);
    }
    catch(err) {
      throw new MongoError("Failed to delete discussion by id " + err);
    }

    if(!discussion) {
      throw new MongoError("Discussion not found");
    }

    return discussion;
  }

  public async fetchByIdIfHasMember(discussionId: string, participantId: string): Promise<Documents.Discussion | null> {
    let discussion: Documents.Discussion;

    try {
      discussion = await crud.findOne<Documents.Discussion>({_id: discussionId}, this.discussionModel);
    }
    catch(err) {
      throw new MongoError('Has member error');
    }

    if(!discussion) {
      throw new MongoError('Discussion not found');
    }

    switch(discussion.type) {
      case 'simple_discussion':
          if(participantId === discussion.participant1.toString() || participantId === discussion.participant2.toString() ) {
            return discussion;
          }
          return null;
      case 'group_discussion':
          if((discussion.participants as [IUser]).find(participant => participant._id.toString() === participantId)) {
            return discussion
          }
          return null;
      default: 
      throw new MongoError('Undefined discussion type');
    }
  }
}
