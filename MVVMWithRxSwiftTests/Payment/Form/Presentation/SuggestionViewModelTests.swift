//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import XCTest
import MVVMWithRxSwift

class SuggestionViewModelTests: XCTestCase {
    
    func test_text_isBasedOnProvidedSuggestionValues() {
        let suggestion = Suggestion(iban: "123", taxNumber: "456")
        
        let sut = SuggestionViewModel(suggestion)
        
        XCTAssertEqual(sut.text, "Iban: 123 | Tax number: 456")
    }
    
    func test_textWithoutIban_isBasedOnProvidedSuggestionValues() {
        let suggestion = Suggestion(iban: nil, taxNumber: "456")
        
        let sut = SuggestionViewModel(suggestion)
        
        XCTAssertEqual(sut.text, "Tax number: 456")
    }
    
    func test_textWithoutTaxNumber_isBasedOnProvidedSuggestionValues() {
        let suggestion = Suggestion(iban: "123", taxNumber: nil)
        
        let sut = SuggestionViewModel(suggestion)
        
        XCTAssertEqual(sut.text, "Iban: 123")
    }
    
    func test_textWithoutIbanAndTaxNumber_isEmpty() {
        let suggestion = Suggestion(iban: nil, taxNumber: nil)
        
        let sut = SuggestionViewModel(suggestion)
        
        XCTAssertEqual(sut.text, "")
    }
    
    func test_isEqual_whenIbanAndTextMatches() {
        let s1 = SuggestionViewModel(Suggestion(iban: "111", taxNumber: "222"))
        let s2 = SuggestionViewModel(Suggestion(iban: "333", taxNumber: "444"))
        
        XCTAssertNotEqual(s1, s2)
        XCTAssertEqual(s1, s1)
    }

    func test_identity_isText() {
        let s1 = SuggestionViewModel(Suggestion(iban: "111", taxNumber: "222"))
        let s2 = SuggestionViewModel(Suggestion(iban: "333", taxNumber: "444"))

        XCTAssertEqual(s1.identity, s1.text)
        XCTAssertEqual(s2.identity, s2.text)
    }

}
