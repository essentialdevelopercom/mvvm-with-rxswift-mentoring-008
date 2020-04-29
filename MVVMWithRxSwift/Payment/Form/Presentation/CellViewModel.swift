//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import Differentiator

public enum CellViewModel: Equatable {
    case field(FieldViewModel)
    case suggestion(SuggestionViewModel)
}

extension CellViewModel: IdentifiableType {
    public var identity: String {
        switch self {
        case let .field(vm): return vm.title
        case let .suggestion(vm): return vm.text
        }
    }
}
