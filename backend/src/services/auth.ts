import { Service, Inject } from 'typedi';
import { IUserInputDTO, IUser } from '../interfaces/user';
import { Logger } from 'winston';
import * as crud from '../utils/crud';
import * as jwt from '../utils/jwt';
import { MongoError } from 'mongodb';
import MediaService from './media';

@Service()
export default class AuthService {
  constructor(
    @Inject('logger') private logger: Logger,
    @Inject('userModel') private userModel: Models.User,
    private mediaService: MediaService,
  ) {}

  /**
   * @description Register a user
   * @param {IUserInputDTO} userInputDTO
   * @return {Promise<{ user: IUser; token: string }>} The created user and a JWT token
   * @throws {MongoError} MongoError
   */
  public async register(userInputDTO: IUserInputDTO): Promise<{ user: IUser; token: string }> {
    let media: Documents.Media;
    let user: Documents.User;

    try {
      user = await crud.create<IUser>(
        {username: userInputDTO.username, password: userInputDTO.password},
        this.userModel,
      );
    } catch (err) {
      throw new MongoError('Catch a Mongo error ==> ' + err);
    }

    if (!user) {
      throw new MongoError('Failed to create a user');
    }

    try {
      media = await this.mediaService.create({
        name: userInputDTO.avatar,
        owner: user._id,
      });
    } catch (err) {
      throw new MongoError('Failed to create user avatar');
    }

    user.avatar = media._id;

    await user.populate('avatar').execPopulate();

    const token = jwt.generateToken(user);

    Reflect.deleteProperty(user, 'password');

    return { user: user, token: token };
  }

  /**
   * @description Log in a user
   * @param {string} username
   * @param {string} password
   * @return {Promise<{ user: IUser; token: string }>} The logged user and a JWT token
   * @throws {MongoError} MongoDb error
   */
  public async login(username: string, password: string): Promise<{ user: IUser; token: string }> {
    let user: Documents.User;

    try {
      user = await crud.findOne<IUser>({ username: username }, this.userModel);
    } catch (err) {
      throw new MongoError(`Failed to find user, ${err}`);
    }

    if (!user) {
      throw new MongoError('User not found');
    }

    const isPasswordValid = password == user.password;

    if (isPasswordValid) {
      const token = jwt.generateToken(user);

      return { user: user, token: token };
    }

    throw new MongoError('Incorrect password');
  }

  /**
   * @description Update password user password
   * @param {string} username
   * @param {string} oldPassword
   * @param {string} password
   * @return {Promise<{ user: IUser; token: string }>} The updated user and a JWT token
   * @throws {MongoError} MongoDb error
   */
  public async updatePassword(username: string, oldPassword: string, newPassword: string): Promise<{ user: IUser; token: string }> {
    let user: Documents.User;

    try {
      user = await crud.updateOne<IUser>({ username: username, password: oldPassword }, {$set: {password: newPassword}}, {new: true, runValidators: true}, this.userModel);
    } catch (err) {
      throw new MongoError(`Failed to update user password, ${err}`);
    }

    if (!user) {
      throw new MongoError("Incorrect username or old password");
    }

    const token = jwt.generateToken(user);

    return { user: user, token: token };
  }
}
