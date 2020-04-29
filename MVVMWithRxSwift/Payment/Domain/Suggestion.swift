//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

public struct Suggestion: Equatable {
    public let iban: String?
    public let taxNumber: String?
    
    public init(iban: String?, taxNumber: String?) {
        self.iban = iban
        self.taxNumber = taxNumber
    }
}
