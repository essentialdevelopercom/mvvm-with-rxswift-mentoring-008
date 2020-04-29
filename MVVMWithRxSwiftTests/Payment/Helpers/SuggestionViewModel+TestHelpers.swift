//
//  SuggestionViewModel+TestHelpers.swift
//  MVVMWithRxSwiftTests
//
//  Created by Caio Zullo on 30/04/2020.
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import RxCocoa
import MVVMWithRxSwift

extension SuggestionViewModel {
    init(_ suggestion: Suggestion) {
        self.init(suggestion, select: PublishRelay<Void>())
    }
}
