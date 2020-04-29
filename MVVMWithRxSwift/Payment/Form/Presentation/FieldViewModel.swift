//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import RxCocoa
import Differentiator

public struct FieldViewModel {
    public let title: String
    public let text = BehaviorRelay<String>(value: "")
    public let focus = PublishRelay<Void>()
        
    public init(title: String = "") {
        self.title = title
    }
}

extension FieldViewModel: Equatable {
    public static func == (lhs: FieldViewModel, rhs: FieldViewModel) -> Bool {
        lhs.title == rhs.title && lhs.text.value == rhs.text.value
    }
}

extension FieldViewModel: IdentifiableType {
    public var identity: String { title }
}

extension FieldViewModel {
    public static func iban() -> FieldViewModel {
        return FieldViewModel(title: "IBAN")
    }
    
    public static func taxNumber() -> FieldViewModel {
        return FieldViewModel(title: "Tax number")
    }
    
    public static func bankName() -> FieldViewModel {
        return FieldViewModel(title: "Bank name")
    }
    
    public static func comment() -> FieldViewModel {
        return FieldViewModel(title: "Comment")
    }
}
