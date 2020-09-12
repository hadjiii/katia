import "reflect-metadata";
import * as container from "../utils/container"
import "mocha"
import * as mongoose from "../utils/mongoose"
import chai, { assert } from "chai"
import chaiAsPromised from "chai-as-promised"
import DiscussionService from "../../src/services/discussion"
import { Container } from "typedi";
import logger from "../../src/loaders/logger"
import { IGroupDiscussionInputDTO } from "../../src/interfaces/discussion";
import { MongoError } from "mongodb";

chai.use(chaiAsPromised)

let discussionService: DiscussionService;

describe("DiscussionService tests", () => {
  
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

    discussionService = Container.get(DiscussionService)

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
    await mongoose.loadDataset();
  })

  /**
   * Reset db after each test
   */

  afterEach(async () => {
    await mongoose.resetDb()
  })

  /**
   * Create discussion tests
   */

   it("Should create a simple discussion", async () => {
     const user1 = "5f4566bf2543111325701693";
     const user2 = "5f4566bf2543111325701695";

    let discussion = {
      type: "simple_discussion",
      participant1: user1,
      participant2: user2
    }

    const createdDiscussion = await discussionService.create(discussion);

     assert.exists(createdDiscussion._id)
     assert.equal(createdDiscussion.type, "simple_discussion")
     assert.equal(createdDiscussion.participant1.toString(), user1.toString())
     assert.equal(createdDiscussion.participant2.toString(), user2.toString())
     assert.exists(createdDiscussion.messages)
     assert.exists(createdDiscussion.medias)
     assert.isEmpty(createdDiscussion.messages)
     assert.isEmpty(createdDiscussion.medias)
   })

   it("Should create a group discussion", async () => {
    const user1 = "5f4566bf2543111325701693";
    const user2 = "5f4566bf2543111325701695";

   const participants = [user1.toString(), user2.toString()]

   let discussion: IGroupDiscussionInputDTO = {
     type: "group_discussion",
     name: "Group discussion",
     creator: user1,
     participants: participants
   }

    const createdDiscussion = await discussionService.create(discussion);

    assert.exists(createdDiscussion._id)
    assert.equal(createdDiscussion.type, "group_discussion")
    assert.exists(createdDiscussion.participants)
    assert.exists(createdDiscussion.messages)
    assert.exists(createdDiscussion.medias)
    //assert.includeMembers(discussionParticipants, participants, "Not deep equal")
    assert.includeMembers([1, 3, 6], [6, 1, 3], "My test")
    assert.isEmpty(createdDiscussion.messages)
    assert.isEmpty(createdDiscussion.medias)
   })

   it("Should fail to create a simple discussion with duplicated participant1 and participant2", async () => {
    const user1 = "5f4566bf254311132570168d";
    const user2 = "5f4566bf2543111325701693";

   const discussion = {
     type: "simple_discussion",
     participant1: user1,
     participant2: user2
   }

    assert.isRejected(discussionService.create(discussion), MongoError)
  })

  /**
   * Find discussion tests
   */

  it("Should find discussion by id", async () => {
    const simpleDiscussionId = "5f459cb9635db27f8fe87b89"
    const foundSimpleDiscussion = await discussionService.fetchById(simpleDiscussionId)

    assert.equal(foundSimpleDiscussion._id.toString(), simpleDiscussionId.toString());
    assert.equal(foundSimpleDiscussion.type, "simple_discussion");

    const groupDiscussionId = "5f459cd1480ef178dbca2d36";
    const foundGroupDiscussion = await discussionService.fetchById(groupDiscussionId);

    assert.equal(foundGroupDiscussion._id.toString(), groupDiscussionId.toString());
    assert.equal(foundGroupDiscussion.type, "group_discussion");
  })

  it("Should fail to find unexisted discussions", async () => {
    assert.isRejected(discussionService.fetchById("fakediscussionid"), MongoError)
    assert.isRejected(discussionService.fetchOne({
      owner: "fakeownerid"
    }), MongoError)

    assert.isEmpty(await discussionService.fetchAll({owner: "fakeownerid"}))
  })

  /**
   * Update discussion tests
   */

  it("Should update discussion name", async () => {
    const newGroupName = "Renamed group"
    const groupDiscussionId = "5f459cd1480ef178dbca2d36";

    const renamedDiscusion = await discussionService.updateNameById(groupDiscussionId, newGroupName);
   
    assert.equal(renamedDiscusion.name, newGroupName);
  })

  it("Should fail to update name of unexisted discussion", async () => {
    const newDiscussionName = "Renamed group"
    const groupDiscussionId = "fakediscussionid";

    assert.isRejected(discussionService.updateNameById(groupDiscussionId, newDiscussionName), MongoError)
    
    const simpleDiscussionId = "5f459cb9635db27f8fe87b89";

    assert.isRejected(discussionService.updateNameById(simpleDiscussionId, newDiscussionName), MongoError)
  
  })

  /**
   * Remove discussion tests
   */

  it("Should remove discussion", async () => {
   const simpleDiscussionId = "5f459cb9635db27f8fe87b89"
   const groupDiscussionId = "5f459cd1480ef178dbca2d36";

   const removedSimpleDiscussion = await discussionService.deleteById(simpleDiscussionId);
   const removedgroupDiscussion = await discussionService.deleteById(groupDiscussionId);

   assert.equal(removedSimpleDiscussion._id.toString(), simpleDiscussionId)
   assert.equal(removedSimpleDiscussion.type, "simple_discussion")

   assert.equal(removedgroupDiscussion._id.toString(), groupDiscussionId)
   assert.equal(removedgroupDiscussion.type, "group_discussion")
  })

  it("Should fail to remove unexisted discussions", async () => {
    assert.isRejected(discussionService.deleteById("fakediscussionid"), MongoError)
    // assert.fail("Remove by creator username not implemented")
  })
})