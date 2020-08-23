import "mocha"
import { assert } from "chai"

describe("DiscussionService tests", () => {
  /**
   * Create discussion tests
   */

   it("Should create discussion", () => {
    assert.fail("Not implemented")
   })

   it("Should create a group discussion", () => {
    assert.fail("Not implemented")
   })

  /**
   * Find discussion tests
   */

  it("Should find discussion by id", () => {
    assert.fail("Find by id not implemented")
    assert.fail("Find by creator username not implemented")
  })

  it("Should find discussions by creator", () => {
    assert.fail("Find by creator id not implemented")
    assert.fail("Find by creator username not implemented")
  })

  it("Should fail to find unexisted discussions", () => {
    assert.fail("Find by discussion id not implemented")
    assert.fail("Find by creator id not implemented")
    assert.fail("Find by creator username not implemented")
  })

  /**
   * Update discussion tests
   */

  it("Should update discussion", () => {
    assert.fail("Update by id not implemented")
  })

  it("Should fail to update unexisted discussion", () => {
    assert.fail("Update by id not implemented")
  })

  /**
   * Remove discussion tests
   */

  it("Should remove discussion", () => {
    assert.fail("Remove by id not implemented")
    assert.fail("Remove by creator id not implemented")
    assert.fail("Remove by creator username not implemented")
  })

  it("Should fail to remove unexisted discussions", () => {
    assert.fail("Remove by id not implemented")
    assert.fail("Remove by creator username not implemented")
  })
})