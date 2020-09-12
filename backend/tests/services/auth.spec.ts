import "reflect-metadata";
import * as container from "../utils/container"
import * as mongoose from "../utils/mongoose"
import "mocha"
import chai, { assert } from "chai"
import chaiAsPromised from "chai-as-promised"
import Container from "typedi";
import AuthService from "../../src/services/auth"
import logger from "../../src/loaders/logger"
import { MongoError } from "mongodb";

chai.use(chaiAsPromised)

const testUser = {
  username: "user5",
  password: "test5555",
  avatar: "avatar5.jpg"
}

let authService: AuthService

describe("AuthService tests", () => {

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

    authService = Container.get(AuthService)

    await mongoose.connect()
  })

  /**
   * Stop mongod connection
   * Reset container
   */
  
  after(async () => {
    //await mongoose.disconnect()
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
   * Retrieve AuthService from the container
   */

  it("Should get AuthService from container", () => {
    assert.exists(
      authService,
      "The container doesn't contain an instance of AuthService"
    );
  });

  /**
   * Register tests
   */

  it("Should register a user", async () => {
    const {user, token}  = await authService.register(testUser)

    assert.exists(user, "The user is undefined or null")
    assert.exists(user._id, "The user id is undefined or null")
    assert.equal(user.username, testUser.username, "The username has changed")
    assert.equal(user.password, testUser.password, "The password has changed")

    assert.equal(user.avatar.owner._id.toString(), user._id.toString())
    assert.equal(user.avatar.name, testUser.avatar)

    assert.exists(token, "The token is undefined or null")
  })

  it("Should fail to register a user with invalid username or password", async () => {
    const user = {
      username: "user1",
      password: "Test-1111",
      avatar: "avatar1.jpg"
    }
    // Test error is thrown when username is duplicated
    assert.isRejected(authService.register(user), MongoError)
    
    // Test error is thrown when incorrect username length was given
    assert.isRejected(authService.register({username: " ", password: testUser.password, avatar: testUser.avatar}), MongoError)

    // Test error is thrown when incorrect password length was given
    assert.isRejected(authService.register({username: testUser.username, password: " ", avatar: testUser.avatar}), MongoError)
  })

  /**
   * Login tests
   */

  it("Should log in user", async () => {
    const user = {
      username: "user1",
      password: "Test-1111",
      avatar: "avatar1.jpg"
    }

    const {user: loggedUser, token} = await authService.login(user.username, user.password);

    assert.exists(loggedUser, "The user is undefined or null")
    assert.exists(loggedUser._id, "The user id is undefined or null")
    assert.equal(loggedUser.username, user.username, "The username has changed")
    assert.equal(loggedUser.password, user.password, "The password has changed")
    assert.exists(token, "The token is undefined or null")
  })

  it("Should fail to log in user", () => {
    const user = {
      username: "user1",
      password: "Test-1111"
    }

    assert.isRejected(authService.login("fakeusername", user.password), MongoError)
    assert.isRejected(authService.login(user.username, "fakepassword"), MongoError)
  })

  /**
   * Update password tests
   */

  it("Should update password", async () => {
    const user = {
      username: "user1",
      password: "Test-1111"
    }

    const newPassword = "Test-2222"
    const {user: updatedUser, token} = await authService.updatePassword(user.username, user.password, newPassword);

    assert.exists(updatedUser, "The user is undefined or null")
    assert.exists(updatedUser._id, "The user id is undefined or null")
    assert.equal(updatedUser.username, user.username, "The username has changed")
    assert.equal(updatedUser.password, newPassword, "The password has changed")

    assert.exists(token, "The token is undefined or null")
  })

  it("Should fail to update password", async () => { 
    const user = {
      username: "user1",
      password: "Test-1111"
    }

    const newPassword = "newPassword";

    assert.isRejected(authService.updatePassword("fakeusername", user.password, newPassword), MongoError)
    assert.isRejected(authService.updatePassword(user.username, user.password, " "), MongoError)
    assert.isRejected(authService.updatePassword(user.username, "fakeoldpassword", newPassword), MongoError)
  })
})
