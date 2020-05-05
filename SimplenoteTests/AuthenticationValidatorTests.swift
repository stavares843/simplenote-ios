import XCTest
import XCTest
@testable import Simplenote


// MARK: - AuthenticationValidator Tests
//
class AuthenticationValidatorTests: XCTestCase {

    /// Testing Validator
    ///
    let validator = AuthenticationValidator(hardenedValidation: true, minimumPasswordLength: 8)


    /// Verifies that `performUsernameValidation` returns `true` when the input string is valid
    ///
    func testPerformUsernameValidationReturnsTrueWheneverInputEmailIsValid() {
        let results = [
            validator.performUsernameValidation(username: "j@j.com"),
            validator.performUsernameValidation(username: "something@simplenote.blog"),
            validator.performUsernameValidation(username: "something@simplenote.blog"),
            validator.performUsernameValidation(username: "something@simplenote.blog.ar")
        ]

        for result in results {
            XCTAssert(result == .success)
        }
    }

    /// Verifies that `performPasswordValidation` returns `passwordTooShort` whenever the password doesn't meet the length requirement.
    ///
    func testPerformPasswordValidationReturnsErrorWheneverInputStringIsShorterThanExpected() {
        let result = validator.performPasswordValidation(username: "", password: "")
        XCTAssert(result == .passwordTooShort(length: validator.minimumPasswordLength))
    }

    /// Verifies that `performPasswordValidation` returns `passwordMatchesUsername` whenever the password matches the username.
    ///
    func testPerformPasswordValidationReturnsErrorWheneverPasswordMatchesUsername() {
        let result = validator.performPasswordValidation(username: "somethinghere", password: "somethinghere")
        XCTAssert(result == .passwordMatchesUsername)
    }

    /// Verifies that `performPasswordValidation` returns `passwordContainsInvalidCharacter` whenever the password contains
    /// either Tabs or Newlines.
    ///
    func testPerformPasswordValidationReturnsErrorWheneverPasswordContainsInvalidCharacters() {
        let results = [
            validator.performPasswordValidation(username: "somethinghere", password: "\t12345678"),
            validator.performPasswordValidation(username: "somethinghere", password: "\n12345678"),
            validator.performPasswordValidation(username: "somethinghere", password: "1234\n5678\t"),
            validator.performPasswordValidation(username: "somethinghere", password: "12345678\t")
        ]

        for result in results {
            XCTAssert(result == .passwordContainsInvalidCharacter)
        }
    }
}