//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import RxSwift

public protocol SuggestionsService {
    func perform(request: SuggestionsRequest) -> Single<[Suggestion]>
}

public struct SuggestionsRequest {
    public let query: String
    
    public init(query: String) {
        self.query = query
    }
}
