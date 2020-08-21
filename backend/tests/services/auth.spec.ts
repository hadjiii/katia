import "mocha"
import { assert } from "chai"

describe("Auth services tests", () => {

  /**
   * Register tests
   */

  it("Should register a user", () => {
    assert.fail("Not implemented")
  })

  it("Should fail to register a user with invalid username or password", () => {
    assert.fail("Should fail to register a user with duplicated username not implemented")
    assert.fail("Should fail to register a user with invalid username not implemented")
    assert.fail("Should fail to register a user with invalid password not implemented")
  })

  /**
   * Login tests
   */

  it("Should log in user", () => {
    assert.fail("Not implemented")
  })

  it("Should fail to log in user", () => {
    assert.fail("User not found by id not implmented")
    assert.fail("User not found by username not implmented")
    assert.fail("Incorrect password not implemented")
  })

  /**
   * Update password tests
   */

  it("Should update password", () => {
    assert.fail("Not implemented")
  })

  it("Should fail to update password", () => {
    assert.fail("User not found not implemented")
    assert.fail("Invalid password not implemented")
  })
})
