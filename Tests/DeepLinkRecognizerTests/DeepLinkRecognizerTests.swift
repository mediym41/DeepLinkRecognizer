import XCTest
@testable import DeepLinkRecognizer

final class DeepLinkRecognizerTests: XCTestCase {
    
    // MARK: - Path tests
    // MARK: Term
        
    struct SingleTermDeepLink: DeepLink {
        // properties for configuration
        public static var term = "term"
        
        public static let template = DeepLinkTemplate().term(term)
        let url: URL
        public init(url: URL, values: DeepLinkValues) { self.url = url }
    }
        
    func testHttpPathSingleTermMatches() {
        let singleTermParam = "single"
        
        SingleTermDeepLink.term = singleTermParam
        let matchedURL = URL(string: "http://google.com/\(singleTermParam)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [SingleTermDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) {
            XCTAssertTrue(result is SingleTermDeepLink)
        } else {
            XCTFail()
        }
    }
        
    func testAppPathSingleTermMatches() {
        let singleTermParam = "single"
        
        SingleTermDeepLink.term = singleTermParam
        let matchedURL = URL(string: "app://\(singleTermParam)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [SingleTermDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) {
            XCTAssertTrue(result is SingleTermDeepLink)
        } else {
            XCTFail()
        }
    }
        
    func testPathSingleTermMatches() {
        let singleTermParam = "single"
        
        SingleTermDeepLink.term = singleTermParam
        let matchedURL = URL(string: "/\(singleTermParam)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [SingleTermDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) {
            XCTAssertTrue(result is SingleTermDeepLink)
        } else {
            XCTFail()
        }
    }
        
    func testHttpPathSingleTermNotMatches() {
        let singleTermParam = "single"
        let anotherSingleTermParam = "another"
        
        SingleTermDeepLink.term = singleTermParam
        let matchedURL = URL(string: "http://google.com/\(anotherSingleTermParam)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [SingleTermDeepLink.self])
        let result = recognizer.deepLink(matching: matchedURL)
        
        XCTAssertNil(result)
    }
        
    func testAppPathSingleTermNotMatches() {
        let singleTermParam = "single"
        let anotherSingleTermParam = "another"
        
        SingleTermDeepLink.term = singleTermParam
        let matchedURL = URL(string: "app://\(anotherSingleTermParam)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [SingleTermDeepLink.self])
        let result = recognizer.deepLink(matching: matchedURL)
        
        XCTAssertNil(result)
    }
        
    func testPathSingleTermNotMatches() {
        let singleTermParam = "single"
        let anotherSingleTermParam = "another"
        
        SingleTermDeepLink.term = singleTermParam
        let matchedURL = URL(string: "/\(anotherSingleTermParam)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [SingleTermDeepLink.self])
        let result = recognizer.deepLink(matching: matchedURL)

        XCTAssertNil(result)
    }
        
    struct ManyTermDeepLink: DeepLink {
        public static var firstTerm = "first"
        public static var secondTerm = "second"
        public static var thirdTerm = "third"
        
        public static let template = DeepLinkTemplate()
                                        .term(firstTerm)
                                        .term(secondTerm)
                                        .term(thirdTerm)
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) { self.url = url }
    }
        
    func testHttpPathManyTermMatches() {
        let firstTermParam = "a"
        let secondTermParam = "b"
        let thirdTermParam = "c"
        
        ManyTermDeepLink.firstTerm = firstTermParam
        ManyTermDeepLink.secondTerm = secondTermParam
        ManyTermDeepLink.thirdTerm = thirdTermParam
        let matchedURL = URL(string: "http://google.com/\(firstTermParam)/\(secondTermParam)/\(thirdTermParam)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [ManyTermDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) {
            XCTAssertTrue(result is ManyTermDeepLink)
        } else {
            XCTFail()
        }
    }
        
    func testAppPathManyTermMatches() {
        let firstTermParam = "a"
        let secondTermParam = "b"
        let thirdTermParam = "c"
        
        ManyTermDeepLink.firstTerm = firstTermParam
        ManyTermDeepLink.secondTerm = secondTermParam
        ManyTermDeepLink.thirdTerm = thirdTermParam
        let matchedURL = URL(string: "app://\(firstTermParam)/\(secondTermParam)/\(thirdTermParam)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [ManyTermDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) {
            XCTAssertTrue(result is ManyTermDeepLink)
        } else {
            XCTFail()
        }
    }
        
    func testPathManyTermMatches() {
        let firstTermParam = "a"
        let secondTermParam = "b"
        let thirdTermParam = "c"
        
        ManyTermDeepLink.firstTerm = firstTermParam
        ManyTermDeepLink.secondTerm = secondTermParam
        ManyTermDeepLink.thirdTerm = thirdTermParam
        let matchedURL = URL(string: "/\(firstTermParam)/\(secondTermParam)/\(thirdTermParam)")!
        
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [ManyTermDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) {
            XCTAssertTrue(result is ManyTermDeepLink)
        } else {
            XCTFail()
        }
    }
        
    func testHttpPathManyTermNotMatches() {
        let firstTermParam = "a"
        let secondTermParam = "b"
        let thirdTermParam = "c"
        
        ManyTermDeepLink.firstTerm = firstTermParam
        ManyTermDeepLink.secondTerm = secondTermParam
        ManyTermDeepLink.thirdTerm = thirdTermParam
        let matchedURL = URL(string: "http://google.com/\(thirdTermParam)/\(firstTermParam)/\(secondTermParam)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [ManyTermDeepLink.self])
        let result = recognizer.deepLink(matching: matchedURL)
       
        XCTAssertNil(result)
    }
        
    func testAppPathManyTermNotMatches() {
        let firstTermParam = "a"
        let secondTermParam = "b"
        let thirdTermParam = "c"
        
        ManyTermDeepLink.firstTerm = firstTermParam
        ManyTermDeepLink.secondTerm = secondTermParam
        ManyTermDeepLink.thirdTerm = thirdTermParam
        let matchedURL = URL(string: "app://\(thirdTermParam)/\(firstTermParam)/\(secondTermParam)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [ManyTermDeepLink.self])
        let result = recognizer.deepLink(matching: matchedURL)
        
        XCTAssertNil(result)
    }
        
    func testPathManyTermNotMatches() {
        let firstTermParam = "a"
        let secondTermParam = "b"
        let thirdTermParam = "c"
        
        ManyTermDeepLink.firstTerm = firstTermParam
        ManyTermDeepLink.secondTerm = secondTermParam
        ManyTermDeepLink.thirdTerm = thirdTermParam
        let matchedURL = URL(string: "/\(thirdTermParam)/\(firstTermParam)/\(secondTermParam)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [ManyTermDeepLink.self])
        let result = recognizer.deepLink(matching: matchedURL)
        
        XCTAssertNil(result)
    }
        
    // MARK: Int
        
    struct IntDeepLink: DeepLink {
        public static let template = DeepLinkTemplate().int(named: "number1").int(named: "number2")
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.number1 = values.path["number1"] as! Int
            self.number2 = values.path["number2"] as! Int
        }
        
        let number1: Int
        let number2: Int
    }
        
    func testHttpPathIntMatches() {
        let passedNumber1 = 14
        let passedNumber2 = 41
        
        let matchedURL = URL(string: "http://google.com/\(passedNumber1)/\(passedNumber2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [IntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? IntDeepLink {
            XCTAssertEqual(result.number1, passedNumber1)
            XCTAssertEqual(result.number2, passedNumber2)
        } else {
            XCTFail()
        }
    }
        
    func testAppPathIntMatches() {
        let passedNumber1 = 14
        let passedNumber2 = 41
        
        let matchedURL = URL(string: "app://\(passedNumber1)/\(passedNumber2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [IntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? IntDeepLink {
            XCTAssertEqual(result.number1, passedNumber1)
            XCTAssertEqual(result.number2, passedNumber2)
        } else {
            XCTFail()
        }
    }

    func testPathIntMatches() {
        let passedNumber1 = 14
        let passedNumber2 = 41
        
        let matchedURL = URL(string: "/\(passedNumber1)/\(passedNumber2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [IntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? IntDeepLink {
            XCTAssertEqual(result.number1, passedNumber1)
            XCTAssertEqual(result.number2, passedNumber2)
        } else {
            XCTFail()
        }
    }

    func testHttpPathIntNotMatches() {
        let invalidURL = URL(string: "http://google.com/12/this/is/not/an/number")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [IntDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testAppPathIntNotMatches() {
        let invalidURL = URL(string: "app://12/this/is/not/an/number")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [IntDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testPathIntNotMatches() {
        let invalidURL = URL(string: "/12/this/is/not/an/number")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [IntDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    // MARK: Bool

    struct BoolDeepLink: DeepLink {
        public static let template = DeepLinkTemplate().bool(named: "boolean1").bool(named: "boolean2")
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.boolean1 = values.path["boolean1"] as! Bool
            self.boolean2 = values.path["boolean2"] as! Bool
        }
        
        let boolean1: Bool
        let boolean2: Bool
    }
    
    func testHttpPathBoolMatches() {
        let passedBool1 = true
        let passedBool2 = false
        
        let matchedURL = URL(string: "http://google.com/\(passedBool1)/\(passedBool2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [BoolDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? BoolDeepLink {
            XCTAssertEqual(result.boolean1, passedBool1)
            XCTAssertEqual(result.boolean2, passedBool2)
        } else {
            XCTFail()
        }
    }
    
    func testAppPathBoolMatches() {
        let passedBool1 = true
        let passedBool2 = false
        
        let matchedURL = URL(string: "app://\(passedBool1)/\(passedBool2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [BoolDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? BoolDeepLink {
            XCTAssertEqual(result.boolean1, passedBool1)
            XCTAssertEqual(result.boolean2, passedBool2)
        } else {
            XCTFail()
        }
    }
    
    func testPathBoolMatches() {
        let passedBool1 = true
        let passedBool2 = false
        
        let matchedURL = URL(string: "/\(passedBool1)/\(passedBool2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [BoolDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? BoolDeepLink {
            XCTAssertEqual(result.boolean1, passedBool1)
            XCTAssertEqual(result.boolean2, passedBool2)
        } else {
            XCTFail()
        }
    }
    
    func testHttpPathBoolNotMatches() {
        let invalidURL = URL(string: "http://google.com/this/is/not/bool")!
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [BoolDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testAppPathBoolNotMatches() {
        let invalidURL = URL(string: "app://this/is/not/bool")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [BoolDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testPathBoolNotMatches() {
        let invalidURL = URL(string: "/this/is/not/bool")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [BoolDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    // MARK: Double
    
    struct DoubleDeepLink: DeepLink {
        public static let template = DeepLinkTemplate().double(named: "number1").double(named: "number2")
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.number1 = values.path["number1"] as! Double
            self.number2 = values.path["number2"] as! Double
        }
        
        let number1: Double
        let number2: Double
    }

    func testHttpPathDoubleMatches() {
        let passedDouble1 = 3.14
        let passedDouble2 = 46.78234123
        
        let matchedURL = URL(string: "http://google.com/\(passedDouble1)/\(passedDouble2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [DoubleDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? DoubleDeepLink {
            XCTAssertEqual(result.number1, passedDouble1)
            XCTAssertEqual(result.number2, passedDouble2)
        } else {
            XCTFail()
        }
    }
    
    func testAppPathDoubleMatches() {
        let passedDouble1 = 3.14
        let passedDouble2 = 46.78234123
        
        let matchedURL = URL(string: "app://\(passedDouble1)/\(passedDouble2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [DoubleDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? DoubleDeepLink {
            XCTAssertEqual(result.number1, passedDouble1)
            XCTAssertEqual(result.number2, passedDouble2)
        } else {
            XCTFail()
        }
    }
    
    func testPathDoubleMatches() {
        let passedDouble1 = 3.14
        let passedDouble2 = 46.78234123
        
        let matchedURL = URL(string: "/\(passedDouble1)/\(passedDouble2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [DoubleDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? DoubleDeepLink {
            XCTAssertEqual(result.number1, passedDouble1)
            XCTAssertEqual(result.number2, passedDouble2)
        } else {
            XCTFail()
        }
    }
    
    func testHttpPathDoubleNotMatches() {
        let invalidURL = URL(string: "http://google.com/this/is/not/double")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [DoubleDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testAppPathDoubleNotMatches() {
        let invalidURL = URL(string: "app://this/is/not/double")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [DoubleDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testPathDoubleNotMatches() {
        let invalidURL = URL(string: "/this/is/not/double")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [DoubleDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    // MARK: String
    
    struct StringDeepLink: DeepLink {
        public static let template = DeepLinkTemplate().string(named: "text1").string(named: "text2")
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.text1 = values.path["text1"] as! String
            self.text2 = values.path["text2"] as! String
        }
        
        let text1: String
        let text2: String
    }
    
    func testHttpPathStringMatches() {
        let passedString1 = "number"
        let passedString2 = "1234"
        
        let matchedURL = URL(string: "http://google.com/\(passedString1)/\(passedString2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [StringDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? StringDeepLink {
            XCTAssertEqual(result.text1, passedString1)
            XCTAssertEqual(result.text2, passedString2)
        } else {
            XCTFail()
        }
    }
    
    func testAppPathStringMatches() {
        let passedString1 = "number"
        let passedString2 = "1234"
        
        let matchedURL = URL(string: "app://\(passedString1)/\(passedString2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [StringDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? StringDeepLink {
            XCTAssertEqual(result.text1, passedString1)
            XCTAssertEqual(result.text2, passedString2)
        } else {
            XCTFail()
        }
    }
    
    func testPathStringMatches() {
        let passedString1 = "number"
        let passedString2 = "1234"
        
        let matchedURL = URL(string: "/\(passedString1)/\(passedString2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [StringDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? StringDeepLink {
            XCTAssertEqual(result.text1, passedString1)
            XCTAssertEqual(result.text2, passedString2)
        } else {
            XCTFail()
        }
    }
    
    func testHttpPathStringNotMatches() {
        let invalidURL = URL(string: "http://google.com/?param=foo")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [StringDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        XCTAssertNil(result)
    }
    
    func testAppPathStringNotMatches() {
        let invalidURL = URL(string: "app://?param=foo")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [StringDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testPathStringNotMatches() {
        let invalidURL = URL(string: "/?param=foo")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [StringDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    // MARK: Any
        
    struct AnyDeepLink: DeepLink {
        public static let template = DeepLinkTemplate().any().any()
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) { self.url = url }
    }
    
    func testHttpPathAnyMatches() {
        let passedAny1 = "123_any"
        let passedAny2 = "trash#123"
        
        let matchedURL = URL(string: "http://google.com/\(passedAny1)/\(passedAny2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [AnyDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) {
            XCTAssertTrue(result is AnyDeepLink)
        } else {
            XCTFail()
        }
    }
    
    func testAppPathAnyMatches() {
        let passedAny1 = "123_any"
        let passedAny2 = "trash#123"
        
        let matchedURL = URL(string: "app://\(passedAny1)/\(passedAny2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [AnyDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) {
            XCTAssertTrue(result is AnyDeepLink)
        } else {
            XCTFail()
        }
    }
    
    func testPathAnyMatches() {
        let passedAny1 = "123_any"
        let passedAny2 = "trash#123"
        
        let matchedURL = URL(string: "/\(passedAny1)/\(passedAny2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [AnyDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) {
            XCTAssertTrue(result is AnyDeepLink)
        } else {
            XCTFail()
        }
    }
    
    func testHttpPathAnyNotMatches() {
        let invalidURL = URL(string: "http://google.com/term?param=foo")!
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [AnyDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testAppPathAnyNotMatches() {
        let invalidURL = URL(string: "app://term?param=foo")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [AnyDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testPathAnyNotMatches() {
        let invalidURL = URL(string: "/term?param=foo")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [AnyDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    // MARK: Combined
    
    struct CombinedPathDeepLink: DeepLink {
        public static var term = "term"
        public static let template = DeepLinkTemplate()
                                        .term(term)
                                        .string(named: "text")
                                        .int(named: "int")
                                        .any()
                                        .bool(named: "bool")
                                        .double(named: "double")
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.text = values.path["text"] as! String
            self.int = values.path["int"] as! Int
            self.bool = values.path["bool"] as! Bool
            self.double = values.path["double"] as! Double
        }
        
        let text: String
        let int: Int
        let bool: Bool
        let double: Double
    }
    
    func testHttpPathCombinedMatches() {
        let passedTerm = "some_term"
        let passedString = "some_string"
        let passedInt = 123
        let passedAny = "any123@123"
        let passedBool = true
        let passedDouble = 3.1415
        
        CombinedPathDeepLink.term = passedTerm
        
        let matchedURL = URL(string: "http://google.com/\(passedTerm)/\(passedString)/\(passedInt)/\(passedAny)/\(passedBool)/\(passedDouble)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CombinedPathDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? CombinedPathDeepLink {
            XCTAssertEqual(result.text, passedString)
            XCTAssertEqual(result.int, passedInt)
            XCTAssertEqual(result.bool, passedBool)
            XCTAssertEqual(result.double, passedDouble)
        } else {
            XCTFail()
        }
    }
    
    func testAppPathCombinedMatches() {
        let passedTerm = "some_term"
        let passedString = "some_string"
        let passedInt = 123
        let passedAny = "any123@123"
        let passedBool = true
        let passedDouble = 3.1415
        
        CombinedPathDeepLink.term = passedTerm
        
        let matchedURL = URL(string: "app://\(passedTerm)/\(passedString)/\(passedInt)/\(passedAny)/\(passedBool)/\(passedDouble)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CombinedPathDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? CombinedPathDeepLink {
            XCTAssertEqual(result.text, passedString)
            XCTAssertEqual(result.int, passedInt)
            XCTAssertEqual(result.bool, passedBool)
            XCTAssertEqual(result.double, passedDouble)
        } else {
            XCTFail()
        }
    }
    
    func testPathCombinedMatches() {
        let passedTerm = "some_term"
        let passedString = "some_string"
        let passedInt = 123
        let passedAny = "any123@123"
        let passedBool = true
        let passedDouble = 3.1415
        
        CombinedPathDeepLink.term = passedTerm
        
        let matchedURL = URL(string: "/\(passedTerm)/\(passedString)/\(passedInt)/\(passedAny)/\(passedBool)/\(passedDouble)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CombinedPathDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? CombinedPathDeepLink {
            XCTAssertEqual(result.text, passedString)
            XCTAssertEqual(result.int, passedInt)
            XCTAssertEqual(result.bool, passedBool)
            XCTAssertEqual(result.double, passedDouble)
        } else {
            XCTFail()
        }
    }
    
    func testHttpPathCombinedNotMatches() {
        let invalidURL = URL(string: "http://google.com/string/314.54/any-123-bool/3/false/term")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CombinedPathDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testAppPathCombinedNotMatches() {
        let invalidURL = URL(string: "app://string/314.54/any-123-bool/3/false/term")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CombinedPathDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testPathAnyCombinedNotMatches() {
        let invalidURL = URL(string: "/string/314.54/any-123-bool/3/false/term")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CombinedPathDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    // MARK: - Query tests
        
    // MARK: Required
    
    struct QueryRequiredIntDeepLink: DeepLink {
        public static let template = DeepLinkTemplate()
                                        .queryStringParameters([
                                            .requiredInt(named: "number1"),
                                            .requiredInt(named: "number2")
                                        ])
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.number1 = values.query["number1"] as! Int
            self.number2 = values.query["number2"] as! Int
        }
        
        let number1: Int
        let number2: Int
    }
    
    func testHttpQueryRequiredIntMathces() {
        let passedNumber1 = 456
        let passedNumber2 = 123
        
        let matchedURL = URL(string: "http://google.com/?number2=\(passedNumber2)&number1=\(passedNumber1)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryRequiredIntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryRequiredIntDeepLink {
            XCTAssertEqual(result.number1, passedNumber1)
            XCTAssertEqual(result.number2, passedNumber2)
        } else {
            XCTFail()
        }
    }
    
    func testAppQueryRequiredIntMathces() {
        let passedNumber1 = 456
        let passedNumber2 = 123
        
        let matchedURL = URL(string: "app://?number2=\(passedNumber2)&number1=\(passedNumber1)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryRequiredIntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryRequiredIntDeepLink {
            XCTAssertEqual(result.number1, passedNumber1)
            XCTAssertEqual(result.number2, passedNumber2)
        } else {
            XCTFail()
        }
    }
    
    func testQueryRequiredIntMathces() {
        let passedNumber1 = 456
        let passedNumber2 = 123
        
        let matchedURL = URL(string: "/?number2=\(passedNumber2)&number1=\(passedNumber1)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryRequiredIntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryRequiredIntDeepLink {
            XCTAssertEqual(result.number1, passedNumber1)
            XCTAssertEqual(result.number2, passedNumber2)
        } else {
            XCTFail()
        }
    }
    
    func testHttpQueryRequiredIntNotMathces() {
        let invalidURL = URL(string: "http://google.com/?number2=456&number1=string")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryRequiredIntDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testAppQueryRequiredIntNotMathces() {
        let invalidURL = URL(string: "app://?number2=456&number1=string")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryRequiredIntDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
    
    func testQueryRequiredIntNotMathces() {
        let invalidURL = URL(string: "/?number2=456&number1=string")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryRequiredIntDeepLink.self])
        let result = recognizer.deepLink(matching: invalidURL)
        
        XCTAssertNil(result)
    }
        
    // MARK: Optional
    
    
    struct QueryOptionalIntDeepLink: DeepLink {
        public static let template = DeepLinkTemplate().queryStringParameters([.optionalInt(named: "number1"), .optionalInt(named: "number2")])
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.number1 = values.query["number1"] as? Int
            self.number2 = values.query["number2"] as? Int
        }
        
        let number1: Int?
        let number2: Int?
    }
    
    func testHttpQueryOptionalIntMathces() {
        let passedNumber = 261
        
        let matchedURL = URL(string: "http://google.com/?number2=\(passedNumber)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryOptionalIntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryOptionalIntDeepLink {
            XCTAssertEqual(result.number1, nil)
            XCTAssertEqual(result.number2, passedNumber)
        } else {
            XCTFail()
        }
    }
    
    func testAppQueryOptionalIntMathces() {
        let passedNumber = 261
        
        let matchedURL = URL(string: "app://?number2=\(passedNumber)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryOptionalIntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryOptionalIntDeepLink {
            XCTAssertEqual(result.number1, nil)
            XCTAssertEqual(result.number2, passedNumber)
        } else {
            XCTFail()
        }
    }
    
    func testQueryOptionalIntMathces() {
        let passedNumber = 261
        
        let matchedURL = URL(string: "/?number2=\(passedNumber)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryOptionalIntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryOptionalIntDeepLink {
            XCTAssertEqual(result.number1, nil)
            XCTAssertEqual(result.number2, passedNumber)
        } else {
            XCTFail()
        }
    }
    
    func testHttpQueryOptionalIntNotIncluded() {
        let matchedURL = URL(string: "http://google.com/?notNumber1=456&notNumber2=foo")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryOptionalIntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryOptionalIntDeepLink {
            XCTAssertNil(result.number1)
            XCTAssertNil(result.number2)
        } else {
            XCTFail()
        }
    }
    
    func testAppQueryOptionalIntNotIncluded() {
        let matchedURL = URL(string:"app://?notNumber1=456&notNumber2=foo")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryOptionalIntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryOptionalIntDeepLink {
            XCTAssertNil(result.number1)
            XCTAssertNil(result.number2)
        } else {
            XCTFail()
        }
    }
    
    func testQueryOptionalIntNotIncluded() {
        let matchedURL = URL(string: "/?notNumber1=456&notNumber2=foo")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryOptionalIntDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryOptionalIntDeepLink {
            XCTAssertNil(result.number1)
            XCTAssertNil(result.number2)
        } else {
            XCTFail()
        }
    }
    
    // MARK: Combined
    
    struct QueryCombinedDeepLink: DeepLink {
        public static let template = DeepLinkTemplate().queryStringParameters([
            .requiredInt(named: "requiredInt"), .optionalInt(named: "optionalInt"),
            .requiredBool(named: "requiredBool"), .optionalBool(named: "optionalBool"),
            .requiredString(named: "requiredString"), .optionalString(named: "optionalString"),
            .requiredDouble(named: "requiredDouble"), .optionalDouble(named: "optionalDouble"),
            ])
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.requiredInt = values.query["requiredInt"] as! Int
            self.optionalInt = values.query["optionalInt"] as? Int
            self.requiredBool = values.query["requiredBool"] as! Bool
            self.optionalBool = values.query["optionalBool"] as? Bool
            self.requiredString = values.query["requiredString"] as! String
            self.optionalString = values.query["optionalString"] as? String
            self.requiredDouble = values.query["requiredDouble"] as! Double
            self.optionalDouble = values.query["optionalDouble"] as? Double
        }
        
        let requiredInt: Int
        let optionalInt: Int?
        let requiredBool: Bool
        let optionalBool: Bool?
        let requiredString: String
        let optionalString: String?
        let requiredDouble: Double
        let optionalDouble: Double?
    }
    
    func testHttpQueryCombinedMathces() {
        let passedRequiredInt = 123
        let passedOptionalInt = 456
        let passedRequiredString = "reqStr"
        let passedOptionalString = "optStr"
        let passedRequiredDouble = 1.23
        let passedOptionalDouble = 4.56
        let passedRequiredBool = false
        let passedOptionalBool = true
        
        var urlString = "http://google.com/?"
        urlString += "requiredInt=\(passedRequiredInt)"
        urlString += "&optionalInt=\(passedOptionalInt)"
        urlString += "&requiredString=\(passedRequiredString)"
        urlString += "&optionalString=\(passedOptionalString)"
        urlString += "&requiredDouble=\(passedRequiredDouble)"
        urlString += "&optionalDouble=\(passedOptionalDouble)"
        urlString += "&requiredBool=\(passedRequiredBool)"
        urlString += "&optionalBool=\(passedOptionalBool)"
        
        let matchedURL = URL(string: urlString)!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryCombinedDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryCombinedDeepLink {
            XCTAssertEqual(result.requiredInt, passedRequiredInt)
            XCTAssertEqual(result.optionalInt, passedOptionalInt)
            XCTAssertEqual(result.requiredString, passedRequiredString)
            XCTAssertEqual(result.optionalString, passedOptionalString)
            XCTAssertEqual(result.requiredBool, passedRequiredBool)
            XCTAssertEqual(result.optionalBool, passedOptionalBool)
            XCTAssertEqual(result.requiredDouble, passedRequiredDouble)
            XCTAssertEqual(result.optionalDouble, passedOptionalDouble)
        } else {
            XCTFail()
        }
    }
    
    func testAppQueryCombinedMathces() {
        let passedRequiredInt = 123
        let passedOptionalInt = 456
        let passedRequiredString = "reqStr"
        let passedOptionalString = "optStr"
        let passedRequiredDouble = 1.23
        let passedOptionalDouble = 4.56
        let passedRequiredBool = false
        let passedOptionalBool = true
        
        var urlString = "app://?"
        urlString += "requiredInt=\(passedRequiredInt)"
        urlString += "&optionalInt=\(passedOptionalInt)"
        urlString += "&requiredString=\(passedRequiredString)"
        urlString += "&optionalString=\(passedOptionalString)"
        urlString += "&requiredDouble=\(passedRequiredDouble)"
        urlString += "&optionalDouble=\(passedOptionalDouble)"
        urlString += "&requiredBool=\(passedRequiredBool)"
        urlString += "&optionalBool=\(passedOptionalBool)"
        
        let matchedURL = URL(string: urlString)!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryCombinedDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryCombinedDeepLink {
            XCTAssertEqual(result.requiredInt, passedRequiredInt)
            XCTAssertEqual(result.optionalInt, passedOptionalInt)
            XCTAssertEqual(result.requiredString, passedRequiredString)
            XCTAssertEqual(result.optionalString, passedOptionalString)
            XCTAssertEqual(result.requiredBool, passedRequiredBool)
            XCTAssertEqual(result.optionalBool, passedOptionalBool)
            XCTAssertEqual(result.requiredDouble, passedRequiredDouble)
            XCTAssertEqual(result.optionalDouble, passedOptionalDouble)
        } else {
            XCTFail()
        }
    }
    
    func testQueryCombinedMathces() {
        let passedRequiredInt = 123
        let passedOptionalInt = 456
        let passedRequiredString = "reqStr"
        let passedOptionalString = "optStr"
        let passedRequiredDouble = 1.23
        let passedOptionalDouble = 4.56
        let passedRequiredBool = false
        let passedOptionalBool = true
        
        var urlString = "/?"
        urlString += "requiredInt=\(passedRequiredInt)"
        urlString += "&optionalInt=\(passedOptionalInt)"
        urlString += "&requiredString=\(passedRequiredString)"
        urlString += "&optionalString=\(passedOptionalString)"
        urlString += "&requiredDouble=\(passedRequiredDouble)"
        urlString += "&optionalDouble=\(passedOptionalDouble)"
        urlString += "&requiredBool=\(passedRequiredBool)"
        urlString += "&optionalBool=\(passedOptionalBool)"
        
        let matchedURL = URL(string: urlString)!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryCombinedDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryCombinedDeepLink {
            XCTAssertEqual(result.requiredInt, passedRequiredInt)
            XCTAssertEqual(result.optionalInt, passedOptionalInt)
            XCTAssertEqual(result.requiredString, passedRequiredString)
            XCTAssertEqual(result.optionalString, passedOptionalString)
            XCTAssertEqual(result.requiredBool, passedRequiredBool)
            XCTAssertEqual(result.optionalBool, passedOptionalBool)
            XCTAssertEqual(result.requiredDouble, passedRequiredDouble)
            XCTAssertEqual(result.optionalDouble, passedOptionalDouble)
        } else {
            XCTFail()
        }
    }
    
    struct QueryRequiredArrayDoubleDeepLink: DeepLink {
        public static let template = DeepLinkTemplate()
            .queryStringParameters([.requiredArrayDouble(named: "array")])
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.array = values.query["array"] as! [Double]
        }
        
        let array: [Double]
    }
    
    func testQueryArrayDoubleMatchs() {
        let passedArray: [Double] = [1, -2.1, 0, 0.21, 100.1].shuffled()

        var urlString = "http://domain.com/?"
        urlString += passedArray.map { "array=\($0)" }.joined(separator: "&")
        
        let matchedURL = URL(string: urlString)!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryRequiredArrayDoubleDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryRequiredArrayDoubleDeepLink {
            XCTAssertEqual(result.array.sorted(), passedArray.sorted())
        } else {
            XCTFail()
        }
    }
    
    func testQueryArrayDoubleNotMatchs() {
        let passedArray: [String] = ["first", "second", "next"].shuffled()

        var urlString = "http://domain.com/?"
        urlString += passedArray.map { "array=\($0)" }.joined(separator: "&")
        
        let matchedURL = URL(string: urlString)!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryRequiredArrayDoubleDeepLink.self])
        let result = recognizer.deepLink(matching: matchedURL)
            
        XCTAssertNil(result)
    }
    
    func testQueryArrayDoubleWithTrashMatchs() {
        let doubleArray: [Double] = [1, -2.1, 0, 0.21, 100.1]
        let passedArray = (doubleArray.map { String($0) } + ["trash", "nil", "null"]).shuffled()

        var urlString = "http://domain.com/?"
        urlString += passedArray.map { "array=\($0)" }.joined(separator: "&")
        
        let matchedURL = URL(string: urlString)!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryRequiredArrayDoubleDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryRequiredArrayDoubleDeepLink {
            XCTAssertEqual(result.array.sorted(), doubleArray.sorted())
        } else {
            XCTFail()
        }
    }
    
    struct QueryOptionalArrayDoubleDeepLink: DeepLink {
        public static let template = DeepLinkTemplate(pathParts: [.term("double")],
                                                      parameters: [.optionalArrayDouble(named: "array")])
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.array = values.query["array"] as? [Double]
        }
        
        let array: [Double]?
    }
    
    func testQueryOptionalArrayDoubleWithValuesMatchs() {
        let passedArray: [Double] = [1, -2.1, 0, 0.21, 100.1].shuffled()

        var urlString = "http://domain.com/double?foo=bar&"
        urlString += passedArray.map { "array=\($0)" }.joined(separator: "&")
        
        let matchedURL = URL(string: urlString)!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryOptionalArrayDoubleDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryOptionalArrayDoubleDeepLink {
            XCTAssertEqual(result.array?.sorted(), passedArray.sorted())
        } else {
            XCTFail()
        }
    }
    
    func testQueryOptionalArrayDoubleWithoutValuesMatchs() {
        
        let urlString = "http://domain.com/double?foo=bar"
        
        let matchedURL = URL(string: urlString)!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryOptionalArrayDoubleDeepLink.self])
        
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryOptionalArrayDoubleDeepLink {
            XCTAssertNil(result.array)
        } else {
            XCTFail()
        }
    }
    
    // MARK: Percent decoding
        
    struct QueryRequiredStringDeepLink: DeepLink {
        public static let template = DeepLinkTemplate().queryStringParameters([.requiredString(named: "text")])
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.text = values.query["text"] as! String
        }
        
        let text: String
    }
    
    func testQueryPercentDecoding() {
        let passedEncodedText = "Hello%20G%C3%BCnter"
        let expectedDecodedText = "Hello Günter"
        
        let matchedURL = URL(string: "http://google.com/?text=\(passedEncodedText)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryRequiredStringDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryRequiredStringDeepLink {
            XCTAssertEqual(result.text, expectedDecodedText)
        } else {
            XCTFail()
        }
    }
    
    struct QueryRequiredArrayStringDeepLink: DeepLink {
        public static let template = DeepLinkTemplate().queryStringParameters([.requiredArrayString(named: "text")])
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.array = values.query["text"] as! [String]
        }
        
        let array: [String]
    }
    
    func testQueryArrayPercentDecoding() {
        let passedEncodedText = ["Hello%20G%C3%BCnter", "Hello%20G%C3%BCnter_2"]
        let expectedDecodedText = ["Hello Günter", "Hello Günter_2"]
        
        var baseUrlString = "http://google.com/?"
        baseUrlString += passedEncodedText.map { "text=\($0)" }.joined(separator: "&")
        let matchedURL = URL(string: baseUrlString)!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryRequiredArrayStringDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? QueryRequiredArrayStringDeepLink {
            XCTAssertEqual(result.array.sorted(), expectedDecodedText.sorted())
        } else {
            XCTFail()
        }
    }

    // MARK: - Path and Query test

    func testHttpPathCombinedMathcesWithQueryParams() {
        let passedTerm = "some_term"
        let passedString = "string"
        let passedInt = 123
        let passedAny = "any-123-qwer"
        let passedBool = true
        let passedDouble = 3.14
        
        var urlString = "http://google.com/\(passedTerm)/\(passedString)/\(passedInt)/\(passedAny)/\(passedBool)/\(passedDouble)/?"
        urlString += "requiredInt=123"
        urlString += "&optionalInt=456"
        urlString += "&requiredString=reqStr"
        urlString += "&optionalString=optStr"
        urlString += "&requiredDouble=1.23"
        urlString += "&optionalDouble=4.56"
        urlString += "&requiredBool=true"
        urlString += "&optionalBool=false"
        
        CombinedPathDeepLink.term = passedTerm
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CombinedPathDeepLink.self])
        if let result = recognizer.deepLink(matching: URL(string: urlString)!) as? CombinedPathDeepLink {
            XCTAssertEqual(result.text, passedString)
            XCTAssertEqual(result.int, passedInt)
            XCTAssertEqual(result.bool, passedBool)
            XCTAssertEqual(result.double, passedDouble)
        } else {
            XCTFail()
        }
    }
    
    func testHttpQueryCombinedMathcesWithPathComponents() {
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [QueryCombinedDeepLink.self])
        var urlString = "http://google.com/string/123/any-123-bool/false/3.14/?"
        urlString += "requiredInt=123"
        urlString += "&optionalInt=456"
        urlString += "&requiredString=reqStr"
        urlString += "&optionalString=optStr"
        urlString += "&requiredDouble=1.23"
        urlString += "&optionalDouble=4.56"
        urlString += "&requiredBool=true"
        urlString += "&optionalBool=false"
        
        let result = recognizer.deepLink(matching: URL(string: urlString)!) as? QueryCombinedDeepLink
        
        XCTAssertNil(result)
    }
    
    // MARK: Combined
    
    struct PathQueryCombinedDeepLink: DeepLink {
        public static var term = "term"
        public static let template = DeepLinkTemplate()
            .term(term)
            .string(named: "text")
            .int(named: "int")
            .any()
            .bool(named: "bool")
            .double(named: "double")
            .queryStringParameters([
                .requiredInt(named: "requiredInt"), .optionalInt(named: "optionalInt"),
                .requiredBool(named: "requiredBool"), .optionalBool(named: "optionalBool"),
                .requiredString(named: "requiredString"), .optionalString(named: "optionalString"),
                .requiredDouble(named: "requiredDouble"), .optionalDouble(named: "optionalDouble"),
            ])
        
        let url: URL
        
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            self.text = values.path["text"] as! String
            self.int = values.path["int"] as! Int
            self.bool = values.path["bool"] as! Bool
            self.double = values.path["double"] as! Double
            
            self.requiredInt = values.query["requiredInt"] as! Int
            self.optionalInt = values.query["optionalInt"] as? Int
            self.requiredBool = values.query["requiredBool"] as! Bool
            self.optionalBool = values.query["optionalBool"] as? Bool
            self.requiredString = values.query["requiredString"] as! String
            self.optionalString = values.query["optionalString"] as? String
            self.requiredDouble = values.query["requiredDouble"] as! Double
            self.optionalDouble = values.query["optionalDouble"] as? Double
        }
        
        let text: String
        let int: Int
        let bool: Bool
        let double: Double
        
        let requiredInt: Int
        let optionalInt: Int?
        let requiredBool: Bool
        let optionalBool: Bool?
        let requiredString: String
        let optionalString: String?
        let requiredDouble: Double
        let optionalDouble: Double?
    }
    
    func testHttpPathQueryCombinedMathces() {
        let passedPathTerm = "some_term"
        let passedPathString = "string"
        let passedPathInt = 123
        let passedPathAny = "any-123-qwer"
        let passedPathBool = true
        let passedPathDouble = 3.14
        
        let passedQueryRequiredInt = 123
        let passedQueryOptionalInt = 456
        let passedQueryRequiredString = "reqStr"
        let passedQueryOptionalString = "optStr"
        let passedQueryRequiredDouble = 1.23
        let passedQueryOptionalDouble = 4.56
        let passedQueryRequiredBool = false
        let passedQueryOptionalBool = true
        
        var urlString = "http://google.com"
        urlString += "/\(passedPathTerm)"
        urlString += "/\(passedPathString)"
        urlString += "/\(passedPathInt)"
        urlString += "/\(passedPathAny)"
        urlString += "/\(passedPathBool)"
        urlString += "/\(passedPathDouble)/?"
        
        urlString += "requiredInt=\(passedQueryRequiredInt)"
        urlString += "&optionalInt=\(passedQueryOptionalInt)"
        urlString += "&requiredString=\(passedQueryRequiredString)"
        urlString += "&optionalString=\(passedQueryOptionalString)"
        urlString += "&requiredDouble=\(passedQueryRequiredDouble)"
        urlString += "&optionalDouble=\(passedQueryOptionalDouble)"
        urlString += "&requiredBool=\(passedQueryRequiredBool)"
        urlString += "&optionalBool=\(passedQueryOptionalBool)"
        
        let matchedURL = URL(string: urlString)!
        
        PathQueryCombinedDeepLink.term = passedPathTerm
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [PathQueryCombinedDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? PathQueryCombinedDeepLink {
            XCTAssertEqual(result.text, passedPathString)
            XCTAssertEqual(result.int, passedPathInt)
            XCTAssertEqual(result.bool, passedPathBool)
            XCTAssertEqual(result.double, passedPathDouble)
            
            XCTAssertEqual(result.requiredInt, passedQueryRequiredInt)
            XCTAssertEqual(result.optionalInt, passedQueryOptionalInt)
            XCTAssertEqual(result.requiredString, passedQueryRequiredString)
            XCTAssertEqual(result.optionalString, passedQueryOptionalString)
            XCTAssertEqual(result.requiredBool, passedQueryRequiredBool)
            XCTAssertEqual(result.optionalBool, passedQueryOptionalBool)
            XCTAssertEqual(result.requiredDouble, passedQueryRequiredDouble)
            XCTAssertEqual(result.optionalDouble, passedQueryOptionalDouble)
        } else {
            XCTFail()
        }
    }
    
    func testAppPathQueryCombinedMathces() {
        let passedPathTerm = "some_term"
        let passedPathString = "string"
        let passedPathInt = 123
        let passedPathAny = "any-123-qwer"
        let passedPathBool = true
        let passedPathDouble = 3.14
        
        let passedQueryRequiredInt = 123
        let passedQueryOptionalInt = 456
        let passedQueryRequiredString = "reqStr"
        let passedQueryOptionalString = "optStr"
        let passedQueryRequiredDouble = 1.23
        let passedQueryOptionalDouble = 4.56
        let passedQueryRequiredBool = false
        let passedQueryOptionalBool = true
        
        var urlString = "app:/"
        urlString += "/\(passedPathTerm)"
        urlString += "/\(passedPathString)"
        urlString += "/\(passedPathInt)"
        urlString += "/\(passedPathAny)"
        urlString += "/\(passedPathBool)"
        urlString += "/\(passedPathDouble)/?"
        
        urlString += "requiredInt=\(passedQueryRequiredInt)"
        urlString += "&optionalInt=\(passedQueryOptionalInt)"
        urlString += "&requiredString=\(passedQueryRequiredString)"
        urlString += "&optionalString=\(passedQueryOptionalString)"
        urlString += "&requiredDouble=\(passedQueryRequiredDouble)"
        urlString += "&optionalDouble=\(passedQueryOptionalDouble)"
        urlString += "&requiredBool=\(passedQueryRequiredBool)"
        urlString += "&optionalBool=\(passedQueryOptionalBool)"
        
        let matchedURL = URL(string: urlString)!
        
        PathQueryCombinedDeepLink.term = passedPathTerm
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [PathQueryCombinedDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? PathQueryCombinedDeepLink {
            XCTAssertEqual(result.text, passedPathString)
            XCTAssertEqual(result.int, passedPathInt)
            XCTAssertEqual(result.bool, passedPathBool)
            XCTAssertEqual(result.double, passedPathDouble)
            
            XCTAssertEqual(result.requiredInt, passedQueryRequiredInt)
            XCTAssertEqual(result.optionalInt, passedQueryOptionalInt)
            XCTAssertEqual(result.requiredString, passedQueryRequiredString)
            XCTAssertEqual(result.optionalString, passedQueryOptionalString)
            XCTAssertEqual(result.requiredBool, passedQueryRequiredBool)
            XCTAssertEqual(result.optionalBool, passedQueryOptionalBool)
            XCTAssertEqual(result.requiredDouble, passedQueryRequiredDouble)
            XCTAssertEqual(result.optionalDouble, passedQueryOptionalDouble)
        } else {
            XCTFail()
        }
    }
    
    func testPathQueryCombinedMathces() {
        let passedPathTerm = "some_term"
        let passedPathString = "string"
        let passedPathInt = 123
        let passedPathAny = "any-123-qwer"
        let passedPathBool = true
        let passedPathDouble = 3.14
        
        let passedQueryRequiredInt = 123
        let passedQueryOptionalInt = 456
        let passedQueryRequiredString = "reqStr"
        let passedQueryOptionalString = "optStr"
        let passedQueryRequiredDouble = 1.23
        let passedQueryOptionalDouble = 4.56
        let passedQueryRequiredBool = false
        let passedQueryOptionalBool = true
        
        var urlString = ""
        urlString += "/\(passedPathTerm)"
        urlString += "/\(passedPathString)"
        urlString += "/\(passedPathInt)"
        urlString += "/\(passedPathAny)"
        urlString += "/\(passedPathBool)"
        urlString += "/\(passedPathDouble)/?"
        
        urlString += "requiredInt=\(passedQueryRequiredInt)"
        urlString += "&optionalInt=\(passedQueryOptionalInt)"
        urlString += "&requiredString=\(passedQueryRequiredString)"
        urlString += "&optionalString=\(passedQueryOptionalString)"
        urlString += "&requiredDouble=\(passedQueryRequiredDouble)"
        urlString += "&optionalDouble=\(passedQueryOptionalDouble)"
        urlString += "&requiredBool=\(passedQueryRequiredBool)"
        urlString += "&optionalBool=\(passedQueryOptionalBool)"
        
        let matchedURL = URL(string: urlString)!
        
        PathQueryCombinedDeepLink.term = passedPathTerm
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [PathQueryCombinedDeepLink.self])
        if let result = recognizer.deepLink(matching: matchedURL) as? PathQueryCombinedDeepLink {
            XCTAssertEqual(result.text, passedPathString)
            XCTAssertEqual(result.int, passedPathInt)
            XCTAssertEqual(result.bool, passedPathBool)
            XCTAssertEqual(result.double, passedPathDouble)
            
            XCTAssertEqual(result.requiredInt, passedQueryRequiredInt)
            XCTAssertEqual(result.optionalInt, passedQueryOptionalInt)
            XCTAssertEqual(result.requiredString, passedQueryRequiredString)
            XCTAssertEqual(result.optionalString, passedQueryOptionalString)
            XCTAssertEqual(result.requiredBool, passedQueryRequiredBool)
            XCTAssertEqual(result.optionalBool, passedQueryOptionalBool)
            XCTAssertEqual(result.requiredDouble, passedQueryRequiredDouble)
            XCTAssertEqual(result.optionalDouble, passedQueryOptionalDouble)
        } else {
            XCTFail()
        }
    }
    
    // MARK: - Searches through deep link types (Collisions)
    func testSearchesThroughDeepLinkTypes() {
        let passedNumber1: Double = 3.14
        let passedNumber2: Double = 15
        
        let matchedURL = URL(string: "test://\(passedNumber1)/\(passedNumber2)")!
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [IntDeepLink.self,
                                                            BoolDeepLink.self,
                                                            DoubleDeepLink.self,
                                                            StringDeepLink.self])
        if let deepLink = recognizer.deepLink(matching: matchedURL) as? DoubleDeepLink {
            XCTAssertEqual(deepLink.number1, passedNumber1)
            XCTAssertEqual(deepLink.number2, passedNumber2)
        } else {
            XCTFail()
        }
    }
        
    // MARK: - Collisions
    
    // MARK: Path
    
    struct CollisionAnyDeepLink: DeepLink {
        public static let template = DeepLinkTemplate(pathParts: [.any, .any, .any, .any])
        let url: URL
        public init(url: URL, values: DeepLinkValues) { self.url = url }
    }
    
    struct CollisionStringDeepLink: DeepLink {
        public static let template = DeepLinkTemplate(pathParts: [.string("1"), .string("2"), .string("3"), .string("4")])
        let url: URL
        public init(url: URL, values: DeepLinkValues) { self.url = url }
    }
    
    struct CollisionDoubleDeepLink: DeepLink {
        public static let template = DeepLinkTemplate(pathParts: [.double("1"), .double("2"), .double("3"), .double("4")])
        let url: URL
        public init(url: URL, values: DeepLinkValues) { self.url = url }
    }
    
    struct CollisionIntDeepLink: DeepLink {
        public static let template = DeepLinkTemplate(pathParts: [.int("1"), .int("2"), .int("3"), .int("4")])
        let url: URL
        public init(url: URL, values: DeepLinkValues) { self.url = url }
    }
    
    struct CollisionTermDeepLink: DeepLink {
        public static let template = DeepLinkTemplate(pathParts: [.term("0"), .term("2"), .term("4"), .term("6")])
        let url: URL
        public init(url: URL, values: DeepLinkValues) { self.url = url }
    }
    
    struct CollisionTrashDeepLink: DeepLink {
        public static let template = DeepLinkTemplate(pathParts: [.any, .int("1"), .term("2"), .int("3"), .bool("4")])
        let url: URL
        public init(url: URL, values: DeepLinkValues) { self.url = url }
    }
    
    
    func testTermCollisionByAscendingOrder() {

        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CollisionAnyDeepLink.self,
                                                            CollisionStringDeepLink.self,
                                                            CollisionDoubleDeepLink.self,
                                                            CollisionIntDeepLink.self,
                                                            CollisionTermDeepLink.self,
                                                            CollisionTrashDeepLink.self])
        let termDeepLink = URL(string: "http://domain.com/0/2/4/6")!
        
        // When
        let deepLink = recognizer.deepLink(matching: termDeepLink)
        
        XCTAssertTrue(deepLink is CollisionTermDeepLink)
    }
    
    func testTermCollisionByDescendingOrder() {
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CollisionTrashDeepLink.self,
                                                            CollisionTermDeepLink.self,
                                                            CollisionIntDeepLink.self,
                                                            CollisionDoubleDeepLink.self,
                                                            CollisionStringDeepLink.self,
                                                            CollisionAnyDeepLink.self])
        let termDeepLink = URL(string: "http://domain.com/0/2/4/6")!
        
        // When
        let deepLink = recognizer.deepLink(matching: termDeepLink)
        
        XCTAssertTrue(deepLink is CollisionTermDeepLink)
    }
    
    func testIntCollisionByAscendingOrder() {
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CollisionAnyDeepLink.self,
                                                            CollisionStringDeepLink.self,
                                                            CollisionDoubleDeepLink.self,
                                                            CollisionIntDeepLink.self,
                                                            CollisionTermDeepLink.self,
                                                            CollisionTrashDeepLink.self])
        let termDeepLink = URL(string: "http://domain.com/1/2/3/4")!
        
        // When
        let deepLink = recognizer.deepLink(matching: termDeepLink)
        
        XCTAssertTrue(deepLink is CollisionIntDeepLink)
    }
    
    func testIntCollisionByDescendingOrder() {
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CollisionTrashDeepLink.self,
                                                            CollisionTermDeepLink.self,
                                                            CollisionIntDeepLink.self,
                                                            CollisionDoubleDeepLink.self,
                                                            CollisionStringDeepLink.self,
                                                            CollisionAnyDeepLink.self])
        let termDeepLink = URL(string: "http://domain.com/1/2/3/4")!
        
        // When
        let deepLink = recognizer.deepLink(matching: termDeepLink)
        
        XCTAssertTrue(deepLink is CollisionIntDeepLink)
    }
    
    func testStringCollisionByAscendingOrder() {
        
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CollisionAnyDeepLink.self,
                                                            CollisionStringDeepLink.self,
                                                            CollisionDoubleDeepLink.self,
                                                            CollisionIntDeepLink.self,
                                                            CollisionTermDeepLink.self,
                                                            CollisionTrashDeepLink.self])
        let termDeepLink = URL(string: "http://domain.com/str1/str2/str3/str4")!
        
        // When
        let deepLink = recognizer.deepLink(matching: termDeepLink)
        
        XCTAssertTrue(deepLink is CollisionStringDeepLink)
    }
    
    func testStringCollisionByDescendingOrder() {
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [CollisionTrashDeepLink.self,
                                                            CollisionTermDeepLink.self,
                                                            CollisionIntDeepLink.self,
                                                            CollisionDoubleDeepLink.self,
                                                            CollisionStringDeepLink.self,
                                                            CollisionAnyDeepLink.self])
        let termDeepLink = URL(string: "http://domain.com/str1/str2/str3/str4")!
        
        // When
        let deepLink = recognizer.deepLink(matching: termDeepLink)
        
        XCTAssertTrue(deepLink is CollisionStringDeepLink)
    }
    
    // MARK: Query
    
    struct FragmentDeepLink: DeepLink {
        public static let template = DeepLinkTemplate(pathParts: [.any])
        let url: URL
        let fragment: String?
        public init(url: URL, values: DeepLinkValues) {
            self.url = url
            fragment = values.fragment
        }
    }

    func testQueryCollisionByAscendingOrder() {
        
        let recognizer = DeepLinkRecognizer(deepLinkTypes: [FragmentDeepLink.self])
        let termDeepLink = URL(string: "http://domain.com/any#discount")!
        
        // When
        let deepLink = recognizer.deepLink(matching: termDeepLink) as? FragmentDeepLink
        
        XCTAssertEqual(deepLink?.fragment, "discount")
    }
    
}
