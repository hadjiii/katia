import "reflect-metadata";
import "mocha"
import chai, { assert } from "chai"
import MediaService from "../../src/services/media";
import * as mongoose from "../utils/mongoose"
import Container from "typedi";
import * as container from "../utils/container"
import logger from "../../src/loaders/logger"
import chaiAsPromised = require("chai-as-promised");
import { MongoError } from "mongodb";

chai.use(chaiAsPromised)

let mediaService: MediaService

describe("MediaService tests", () => {

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

    mediaService = Container.get(MediaService)

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
   * Create media tests
   */

  it("Should create media", async () => {
    const media = {
        owner: "5f4566bf2543111325701695",
        name: "test_media.jpg"
    }

    const createdMedia = await mediaService.create(media)

    assert.equal(createdMedia.owner._id.toString(), media.owner)
    assert.equal(createdMedia.name, media.name)
  })

  it("Should fail to create media", async () => {
    const media = {
        owner: "fakeowner",
        name: "test_media.jpg"
    }

    assert.isRejected(mediaService.create(media), MongoError)
  })

  /**
   * Find media tests
   */

  it("Should find media", async () => {
    const media = {
      id: "5f4566bf2543111325701696",
      owner: "5f4566bf2543111325701695",
      name: "avartar3.jpg"
    }

    let foundMedia = await mediaService.fetchOne({
        _id: media.id
    })

    assert.equal(foundMedia._id.toString(), media.id)
    assert.equal(foundMedia.owner._id, media.owner)
    assert.equal(foundMedia.name, media.name)
  })

  it("Should fail to find unexisted media", () => {
    assert.isRejected(mediaService.fetchOne({
        _id: "fakeid"
    }), MongoError)
  })

  /**
   * Update media tests
   */

  it("Should update media", () => {
    assert.fail("Update by id not implemented")
  })

  it("Should fail to update unexisted media", () => {
    assert.isRejected(mediaService.deleteOne({_id: "fakemediaid"}), MongoError);
    assert.isRejected(mediaService.deleteOne({_id: "5f4a19d0e5fa02f1d8235c5f"}), MongoError);
  })

  /**
   * Remove media tests
   */

  it("Should remove media", async () => {
    const mediaId = "5f4566bf254311132570168e"
    const deletedMedia = await mediaService.deleteOne({_id: mediaId})
    
    assert.equal(deletedMedia._id.toString(), mediaId)
  })

  it("Should fail to remove unexisted media", async () => {
    assert.isRejected(mediaService.deleteOne({
        _id: "fakemediaid"
    }), MongoError)
    assert.isRejected(mediaService.deleteOne({
        owner: "fakeownerid"
    }), MongoError)
  })
})