import "reflect-metadata";
import * as container from "../utils/container"
import * as mongoose from "../utils/mongoose"
import "mocha"
import chai, { assert } from "chai"
import chaiAsPromised = require("chai-as-promised");
import MessageService from "../../src/services/message";
import { Container } from "typedi";
import logger from "../../src/loaders/logger"
import { IMessageInputDTO } from "../../src/interfaces/message";
import { MongoError } from "mongodb";
import {groupDiscussion1} from "../utils/dataset/discussion"
import * as users from "../utils/dataset/user";

chai.use(chaiAsPromised)

let messageService: MessageService;

describe("MessageService tests", () => {

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

    messageService = Container.get(MessageService)

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
   * Create message tests
   */

  it("Should create message", async () => {
      console.log("debug ====>", users.user1)
    const message: IMessageInputDTO = {
      discussion: "5f459cb9635db27f8fe87b89",
      sender: "5f4566bf254311132570168d",
      content: {
          media: "new_image.jpg",
          text: "5f4566bf254311132570168d"
      }
    }

    const addedMessage = await messageService.create(message);

    assert.exists(addedMessage._id);
    assert.equal(addedMessage.sender._id, message.sender);
    assert.equal(addedMessage.discussion._id, message.discussion);
    assert.equal(addedMessage.content, message.content);
  })

  it("Should fail to create message", async () => {
    const message: IMessageInputDTO = {
      discussion: "",
      sender: "",
      content: {
        media: "",
        text: ""
      }
    }

    assert.isRejected(messageService.create(message), MongoError);
  })

  /**
   * Find message tests
   */

  it("Should find message", async () => {
    const messageId = "5f45c228a47d5fd704ed7193"
    const foundMessage = await messageService.fetchOneById(messageId)

    assert.equal(foundMessage._id, messageId)

    const discussionId = "5f459cb9635db27f8fe87b89"
    const foundMessages = await messageService.fetchByDiscussionId(discussionId)
    
    assert.lengthOf(foundMessages, 2)
  })

  it("Should fail to find unexisted message", async () => {
    assert.isRejected(messageService.fetchOneById("fakemessageid"), MongoError);
    assert.isRejected(messageService.fetchByDiscussionId("fakediscussionid"), MongoError);
    assert.isEmpty(messageService.fetchByDiscussionId("5f4566bf254311132570168e"));
  })

  /**
   * Update message tests
   */

  it("Should update message", () => {
    assert.fail("Update by id not implemented")
  })

  it("Should fail to update unexisted message", () => {
    assert.fail("Update by id not implemented")
  })

  /**
   * Remove message tests
   */

  it("Should remove message", async () => {
    const messageId = "5f45c24a0ec9e6e756c43954"
    const deleteMessage = await messageService.deleteById(messageId)

    assert.equal(deleteMessage._id, messageId);

    const discussionId = "5f459cdd4a8480559015bb60"
    const deleteMessages = await  messageService.deleteByDiscussionId(discussionId)
    // { n: 3, ok: 1, deletedCount: 3 }
    // assert.equal(deleteMessages.deletedCount, 3)
  })

  it("Should fail to remove unexisted message", async () => {
    assert.isRejected(messageService.deleteById("fakemessageid"), MongoError);
    assert.isRejected(messageService.deleteByDiscussionId("fakediscussionid"), MongoError);
  })
})