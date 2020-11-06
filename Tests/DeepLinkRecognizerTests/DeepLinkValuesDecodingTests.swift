import XCTest
@testable import DeepLinkRecognizer

final class DeepLinkValuesDecodingTests: XCTestCase {
  
    // MARK: - Path
    
    func testSuccessfulBoolPathDecoding() {
        
        // given
        let expectedValue: Bool = true
        let sut = DeepLinkValues(path: ["foo": expectedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            let value = try sut.decodePathItem(Bool.self, forKey: "foo")
            
            // then
            XCTAssertEqual(expectedValue, value)
            
        } catch {
            XCTFail("Must be successful decode")
        }
    }
    
    func testSuccessfulIntPathDecoding() {
        
        // given
        let expectedValue: Int = 314
        let sut = DeepLinkValues(path: ["foo": expectedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            let value = try sut.decodePathItem(Int.self, forKey: "foo")
            
            // then
            XCTAssertEqual(expectedValue, value)
            
        } catch {
            XCTFail("Must be successful decode")
        }
    }
    
    func testSuccessfulDoublePathDecoding() {
        
        // given
        let expectedValue: Double = 3.14
        let sut = DeepLinkValues(path: ["foo": expectedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            let value = try sut.decodePathItem(Double.self, forKey: "foo")
            
            // then
            XCTAssertEqual(expectedValue, value)
            
        } catch {
            XCTFail("Must be successful decode")
        }
    }
    
    func testSuccessfulStringPathDecoding() {
        
        // given
        let expectedValue: String = "3.14"
        let sut = DeepLinkValues(path: ["foo": expectedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            let value = try sut.decodePathItem(String.self, forKey: "foo")
            
            // then
            XCTAssertEqual(expectedValue, value)
            
        } catch {
            XCTFail("Must be successful decode")
        }
    }
    
    // MARK: Errors
    
    func testFailureStringPathWithoutValueDecoding() {
        
        // given
        let expectedKey = "foo"
        let sut = DeepLinkValues(path: [:])
            .container(keyedBy: String.self)
        
        do {
            // when
            _ = try sut.decodePathItem(String.self, forKey: expectedKey)
            
            // then
            XCTFail("Must be failure decode")
            
        } catch ParametersDecodingError.notFoundKey(let key) {
            XCTAssertEqual(expectedKey, key)
        } catch {
            XCTFail("Must be DeepLinkValuesDecodingError.notFoundKey error")
        }
    }
    
    func testFailureStringPathWithWrongValueDecoding() {
        
        // given
        let passedKey = "foo"
        let passedValue = 3.14
        let expectedActualType = String(describing: type(of: passedValue))
        let expectedType = String.self
        
        let sut = DeepLinkValues(path: [passedKey: passedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            _ = try sut.decodePathItem(expectedType, forKey: passedKey)
            
            // then
            XCTFail("Must be failure decode")
            
        } catch ParametersDecodingError.typecastFailed(let key, let actual, let expected) {
            XCTAssertEqual(passedKey, key)
            XCTAssertEqual(expectedActualType, actual)
            XCTAssertEqual(String(describing: expectedType), expected)
        } catch {
            XCTFail("Must be DeepLinkValuesDecodingError.typecastFailed error")
        }
    }
    
    // MARK: - Query
    
    func testSuccessfulBoolQueryDecoding() {
        
        // given
        let expectedValue: Bool = true
        let sut = DeepLinkValues(query: ["foo": expectedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            let value = try sut.decodeQueryItem(Bool.self, forKey: "foo")
            
            // then
            XCTAssertEqual(expectedValue, value)
            
        } catch {
            XCTFail("Must be successful decode")
        }
    }
    
    func testSuccessfulIntQueryDecoding() {
        
        // given
        let expectedValue: Int = 314
        let sut = DeepLinkValues(query: ["foo": expectedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            let value = try sut.decodeQueryItem(Int.self, forKey: "foo")
            
            // then
            XCTAssertEqual(expectedValue, value)
            
        } catch {
            XCTFail("Must be successful decode")
        }
    }
    
    func testSuccessfulDoubleQueryDecoding() {
        
        // given
        let expectedValue: Double = 3.14
        let sut = DeepLinkValues(query: ["foo": expectedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            let value = try sut.decodeQueryItem(Double.self, forKey: "foo")
            
            // then
            XCTAssertEqual(expectedValue, value)
            
        } catch {
            XCTFail("Must be successful decode")
        }
    }
    
    func testSuccessfulStringQueryDecoding() {
        
        // given
        let expectedValue: String = "3.14"
        let sut = DeepLinkValues(query: ["foo": expectedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            let value = try sut.decodeQueryItem(String.self, forKey: "foo")
            
            // then
            XCTAssertEqual(expectedValue, value)
            
        } catch {
            XCTFail("Must be successful decode")
        }
    }
    
    func testFailureStringQueryWithWrongValueDecoding() {
        
        // given
        let passedKey = "foo"
        let passedValue = 3.14
        let expectedActualType = String(describing: type(of: passedValue))
        let expectedType = String.self
        
        let sut = DeepLinkValues(query: [passedKey: passedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            _ = try sut.decodeQueryItem(expectedType, forKey: passedKey)
            
            // then
            XCTFail("Must be failure decode")
            
        } catch ParametersDecodingError.typecastFailed(let key, let actual, let expected) {
            XCTAssertEqual(passedKey, key)
            XCTAssertEqual(expectedActualType, actual)
            XCTAssertEqual(String(describing: expectedType), expected)
        } catch {
            XCTFail("Must be DeepLinkValuesDecodingError.typecastFailed error")
        }
    }
    
    // MARK: Optional
    
    func testSuccessfulOptionalStringQueryWithValueDecoding() {
        
        // given
        let expectedValue: String = "3.14"
        let sut = DeepLinkValues(query: ["foo": expectedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            let value = try sut.decodeQueryItem(String.self, forKey: "foo")
            
            // then
            XCTAssertEqual(expectedValue, value)
            
        } catch {
            XCTFail("Must be successful decode")
        }
    }
    
    func testSuccessfulOptionalStringQueryWithoutValueDecoding() {
        
        // given
        let expectedValue: String? = nil
        let sut = DeepLinkValues(query: [:])
            .container(keyedBy: String.self)
        
        do {
            // when
            let value = try sut.decodeQueryItem(String?.self, forKey: "foo")
            
            // then
            XCTAssertEqual(expectedValue, value)
            
        } catch {
            XCTFail("Must be successful decode")
        }
    }
    
    func testFailureOptionalStringQueryWithWrongValueDecoding() {
        
        // given
        let expectedValue: String = "3.14"
        let sut = DeepLinkValues(query: ["foo": expectedValue])
            .container(keyedBy: String.self)
        
        do {
            // when
            _ = try sut.decodeQueryItem(Double?.self, forKey: "foo")
            
            // then
            XCTFail("Must be failure decode")
            
        } catch ParametersDecodingError.typecastFailed(let key, let actual, let expected) {
            XCTAssertEqual(key, "foo")
            XCTAssertEqual(actual, String(describing: String.self))
            XCTAssertEqual(expected, String(describing: Double?.self))
        } catch {
            XCTFail("Must be DeepLinkValuesDecodingError.typecastFailed error")
        }
    }
    

    
    
}
