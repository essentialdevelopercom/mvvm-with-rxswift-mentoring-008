//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import RxSwift
import MVVMWithRxSwift

class SuggestionsServiceStub: SuggestionsService {
    let stub = (query: "a query", suggestions: [
        Suggestion(iban: "111", taxNumber: "222"),
        Suggestion(iban: "333", taxNumber: "444")
    ])
    
    func perform(request: SuggestionsRequest) -> Single<[Suggestion]> {
        .just(request.query == stub.query ? stub.suggestions : [])
    }
}
