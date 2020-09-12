import { Service, Inject } from 'typedi';
import { Logger } from 'winston';
import { IUser } from '../interfaces/user';
import * as crud from '../utils/crud';
import { MongoError } from "mongodb";

@Service()
export default class UserService {
  constructor(@Inject('logger') private logger: Logger, @Inject('userModel') private userModel: Models.User) {}

  public async fetchById(id: string): Promise<Documents.User> {
    try {
      return await this.fetchOne({_id: id});
    }
    catch(err) {
      throw err
    }
  }

  public async fetchByUsername(username: string): Promise<Documents.User> {
    try {
      return await this.fetchOne({username: username});
    }
    catch(err) {
      throw err
    }
  }

  public async updateUsernameByUserId(id: string, newUsername: string): Promise<Documents.User> {
    try {
      return await this.updateOne({_id: id}, {username: newUsername});
    }
    catch(err) {
      throw err
    }
  }

  public async deleteUserById(id: string): Promise<Documents.User> {
    try {
      return await this.deleteOne({_id: id});
    }
    catch(err) {
      throw err
    }
  }

  public async deleteUserByUsername(username: string): Promise<Documents.User> {
    try {
      return await this.deleteOne({username: username});
    }
    catch(err) {
      throw err
    }
  }

  private async fetchOne(filters: { [filter: string]: any }): Promise<Documents.User> {
    let user: Documents.User;

    try {
      user = await crud.findOne<IUser>(filters, this.userModel);
    }
    catch(err) {
      throw new MongoError('User not found');
    }

    if (!user) {
      throw new MongoError('User not found');
    }

    return user;
  }

  private async fetchAll(filters: { [filter: string]: any }): Promise<Documents.User[]> {
    let users: Documents.User[]

    try {
      users = await crud.findMany<IUser>(filters, this.userModel);
    }
    catch(err) {
      throw new MongoError('Fetch error');
    }
    
    return users;
  }

  private async updateOne(filters: { [filter: string]: any }, values: { [property: string]: any }) {
    let user: Documents.User

    try {
      user = await crud.updateOne<IUser>(filters, values, {new: true}, this.userModel);
    }
    catch(err) {
      throw new MongoError('Fetch error ' + err);
    }

    if (!user) {
      throw new MongoError('User not updated');
    }

    return user;
  }

  private async deleteOne(filters: { [filter: string]: any }) {
    let user: Documents.User

    try {
      user = await crud.deleteOne<IUser>(filters, this.userModel);
    }
    catch(err) {
      throw new MongoError('Delete error' + err);
    }

    if (!user) {
      throw new MongoError('User not deleted');
    }

    return user;
  }
}
