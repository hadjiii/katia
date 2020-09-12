import "reflect-metadata";
import * as container from "../utils/container"
import * as mongoose from "../utils/mongoose"
import "mocha"
import chai, { assert } from "chai"
import chaiAsPromised from "chai-as-promised"
import UserService from "../../src/services/user"
import { MongoError } from "mongodb";
import Container from "typedi";
import logger from "../../src/loaders/logger"

chai.use(chaiAsPromised)

let userService: UserService

describe("UserService tests", () => {

  /**
   * Configure container
   * Connect to mongod
   */

  before(async () => {
    const modelNames = ["user", "media"]

    // container.setupModels(modelNames)

    const userModel = {
        name: "userModel",
        model: require("../../src/models/user").default
      };
      const mediaModel = {
        name: "mediaModel",
        model: require("../../src/models/media").default
      };
      const discussionModel = {
        name: "discussionModel",
        model: require("../../src/models/discussion").Discussion
      };
      const messageModel = {
        name: "messageModel",
        model: require("../../src/models/message").default
      };
      const storyModel = {
        name: "storyModel",
        model: require("../../src/models/story").default
      };
  
      // Setup Container for dependencies injection
      Container.set(userModel.name, userModel.model);
      Container.set(mediaModel.name, mediaModel.model);
      Container.set(discussionModel.name, discussionModel.model);
      Container.set(messageModel.name, messageModel.model);
      Container.set(storyModel.name, storyModel.model);

    Container.set("logger", logger);

    userService = Container.get(UserService)

    await mongoose.connect()
  })

   /**
   * Stop mongod connection
   * Reset container
   */

  after(async () => {
    await mongoose.disconnect()
    container.resetContainer()
  })

  /**
   * Load dataset before each test
   */

  beforeEach(async () => {
    await mongoose.loadDataset()
  })

  /**
   * Reset db after each test
   */

  afterEach(async () => {
    await mongoose.resetDb()
  })

  /**
   * Find user tests
   */

  it("Should find user", async () => {
    let foundUser = await userService.fetchById("5f4566bf254311132570168d")

    assert.equal(foundUser._id.toString(), "5f4566bf254311132570168d")
    assert.equal(foundUser.username, "user1")

    foundUser = await userService.fetchByUsername("user1")

    assert.equal(foundUser._id.toString(), "5f4566bf254311132570168d")
    assert.equal(foundUser.username, "user1")
  })

  it("Should fail to find unexisted user", () => {
    assert.isRejected(userService.fetchById("fakeid"), MongoError)
    assert.isRejected(userService.fetchByUsername("fakeusername"), MongoError)
  })

  /**
   * Update user tests
   */

  it("Should update user", async () => {
    const newUsername = "user6"
    const updatedUser = await userService.updateUsernameByUserId("5f4566bf254311132570168d", newUsername)

    assert.equal(updatedUser.username, newUsername, "Username was not updated")
    assert.equal(updatedUser._id.toString(),"5f4566bf254311132570168d", "The user id has changed")
    assert.equal(updatedUser.password, "test1111", "The user password has changed")
  })

  it("Should fail to update user with duplicated username", async () => {
    assert.isRejected(userService.updateUsernameByUserId("5f4566bf254311132570168d", "user2",), MongoError)
  })

  it("Should fail to update unexisted user", async () => {
    assert.isRejected(userService.updateUsernameByUserId("fakeid", "fakeusername",), MongoError)
  })

  /**
   * Remove user tests
   */

  it("Should remove user", async () => {
    const removedUser = await userService.deleteUserById("5f4566bf254311132570168d")
    assert.equal(removedUser._id.toString(), "5f4566bf254311132570168d")
    assert.equal(removedUser.username, "user1")
    assert.isRejected(userService.fetchById(removedUser._id), MongoError)
    assert.isRejected(userService.fetchByUsername(removedUser.username), MongoError)
    
    const removedUser2 = await userService.deleteUserByUsername("user2")
    assert.equal(removedUser2._id.toString(), "5f4566bf2543111325701693")
    assert.equal(removedUser2.username, "user2")
    assert.isRejected(userService.fetchById(removedUser2._id), MongoError)
    assert.isRejected(userService.fetchByUsername(removedUser2.username), MongoError)
  })

  it("Should fail to remove unexisted user", async () => {
    assert.isRejected(userService.deleteUserById("fakeid"), MongoError)
    assert.isRejected(userService.deleteUserByUsername("fakeusername"), MongoError)
  })
})
