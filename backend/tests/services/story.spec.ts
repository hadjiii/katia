import "reflect-metadata";
import "mocha"
import * as container from "../utils/container"
import * as mongoose from "../utils/mongoose"
import chai, { assert } from "chai"
import chaiAsPromised from "chai-as-promised"
import Container from "typedi";
import StoryService from "../../src/services/story";
import logger from "../../src/loaders/logger"
import { MongoError } from "mongodb";

chai.use(chaiAsPromised);

let storyService: StoryService;

describe("StoryService tests", () => {

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

    storyService = Container.get(StoryService)

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
   * Create story tests
   */

  it("Should create story", async () => {
    const media = {
        owner: "5f4566bf254311132570168d",
        name: "story_media.jpg"
    }

    const story = await storyService.create({
        user: media.owner,
        media: media.name
    })

    assert.equal(story.user._id.toString(), media.owner.toString())
    assert.exists(story.media._id)
  })

  it("Should fail to create story", async () => {
    assert.isRejected(storyService.create({
        user: "fakeid",
        media: "story_media.jpg"
    }), MongoError)
  })

  /**
   * Find story tests
   */

  it("Should find story", async () => {
     const story = await storyService.create({
        user: "5f468824097261ec65a43854",
        media: "story_media.jpg"
    })

    const foundStory = await storyService.fetchOne({
        _id: story._id
    })

    assert.equal(foundStory.user.toString(), story.user.toString())
    assert.equal(foundStory.media.toString(), story.media._id.toString())

    // assert.fail("Find by owner id not implemented")
  })

  it("Should fail to find unexisted story", async () => {
    assert.isRejected(storyService.fetchOne({
        _id: "fakeid"
    }), MongoError)
  })

  /**
   * Update story tests
   */

  it("Should update story", () => {
    assert.fail("Update by id not implemented")
  })

  it("Should fail to update unexisted story", () => {
    assert.fail("Update by id not implemented")
  })

  /**
   * Remove story tests
   */

  it("Should remove story", async () => {
    const removedStory = await storyService.deleteOne({_id: "5f46883029909c81f04755b7"})

    assert.equal(removedStory._id.toString(), "5f46883029909c81f04755b7");
  })

  it("Should fail to remove unexisted story", async () => {
    assert.isRejected(storyService.deleteOne({_id: "fakestoryid"}), MongoError);

    // const res = await storyService.deleteOne({owner: "fakeownerid"});
    // assert.isNull(res);
  })
})