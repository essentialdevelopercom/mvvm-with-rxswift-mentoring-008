//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import RxCocoa
import Differentiator

public struct SuggestionViewModel {
    public let text: String
    public let select: PublishRelay<Void>
    
    public init(_ suggestion: Suggestion, select: PublishRelay<Void>) {
        switch (suggestion.iban, suggestion.taxNumber) {
        case let (.some(iban), .some(taxNumber)):
            self.text = "Iban: \(iban) | Tax number: \(taxNumber)"
        case let (.none, .some(taxNumber)):
            self.text = "Tax number: \(taxNumber)"
        case let (.some(iban), .none):
            self.text = "Iban: \(iban)"
        default:
            self.text = ""
        }
        self.select = select
    }
}

extension SuggestionViewModel: Equatable {
    public static func == (lhs: SuggestionViewModel, rhs: SuggestionViewModel) -> Bool {
        lhs.text == rhs.text
    }
}

extension SuggestionViewModel: IdentifiableType {
    public var identity: String { text }
}
