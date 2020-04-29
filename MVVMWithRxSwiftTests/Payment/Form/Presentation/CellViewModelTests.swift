//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import XCTest
import MVVMWithRxSwift

class CellViewModelTests: XCTestCase {
    
    func test_identity_isValueIdentity() {
        let field = FieldViewModel(title: "a title")
        let c1 = CellViewModel.field(field)
        
        let suggestion = SuggestionViewModel(Suggestion(iban: "111", taxNumber: "222"))
        let c2 = CellViewModel.suggestion(suggestion)

        XCTAssertEqual(c1.identity, field.identity)
        XCTAssertEqual(c2.identity, suggestion.identity)
    }

}
