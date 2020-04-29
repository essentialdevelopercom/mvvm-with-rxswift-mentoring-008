//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import RxSwift

class RandomSuggestionsService: SuggestionsService {
    func perform(request: SuggestionsRequest) -> Single<[Suggestion]> {
        return .just((0...10).map { _ in
            Suggestion(
                iban: "\(Int.random(in: 10000...99999))",
                taxNumber: "\(Int.random(in: 10000...99999))")
        })
    }
}
