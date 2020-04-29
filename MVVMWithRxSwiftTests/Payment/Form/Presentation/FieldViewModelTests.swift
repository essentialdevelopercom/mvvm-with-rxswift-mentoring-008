//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import XCTest
import MVVMWithRxSwift

class FieldViewModelTests: XCTestCase {
    
    func test_isEqual_whenTitleAndTextMatches() {
        let f1 = FieldViewModel(title: "a title")
        let f2 = FieldViewModel(title: "another title")
        
        XCTAssertNotEqual(f1, f2)
        XCTAssertEqual(f1, f1)
        
        let f3 = FieldViewModel(title: "a title")
        f3.text.accept("a text")
        
        XCTAssertNotEqual(f1, f3)
    }
    
    func test_identity_isTitle() {
        let f1 = FieldViewModel(title: "a title")
        let f2 = FieldViewModel(title: "another title")
        
        XCTAssertEqual(f1.identity, f1.title)
        XCTAssertEqual(f2.identity, f2.title)
    }
    
}
