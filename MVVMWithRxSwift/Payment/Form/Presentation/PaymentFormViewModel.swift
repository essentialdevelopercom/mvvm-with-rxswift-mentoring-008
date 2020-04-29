//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import RxCocoa
import RxSwift

public struct PaymentFormViewModel {
    public enum State: Equatable {
        case fields([FieldViewModel])
        case focus(FieldViewModel, [SuggestionViewModel])
    }

    private let iban: FieldViewModel
    private let taxNumber: FieldViewModel
    private let bankName: FieldViewModel
    private let comment: FieldViewModel
    private let service: SuggestionsService
    private let suggestionSelection = PublishRelay<Void>()
    
    public init(
        iban: FieldViewModel = .iban(),
        taxNumber: FieldViewModel = .taxNumber(),
        bankName: FieldViewModel = .bankName(),
        comment: FieldViewModel = .comment(),
        service: SuggestionsService
    ) {
        self.iban = iban
        self.taxNumber = taxNumber
        self.bankName = bankName
        self.comment = comment
        self.service = service
    }

    public var state: Observable<State> {
        let allFields = State.fields([iban, taxNumber, bankName, comment])
        return Observable.merge(
            focus(for: iban),
            focus(for: taxNumber),
            search(for: iban),
            search(for: taxNumber),
            suggestionSelection.map {
                allFields
            },
            .just(allFields)
        )
    }
    
    private func search(for field: FieldViewModel) -> Observable<State> {
        field.text
            .distinctUntilChanged()
            .skip(1)
            .flatMap { [service] query in
                service.perform(request: .init(query: query)).asObservable()
            }.map { [suggestionSelection] suggestions in
                .focus(field, suggestions.map {
                    SuggestionViewModel($0, select: suggestionSelection)
                })
            }
    }
    
    private func focus(for field: FieldViewModel) -> Observable<State> {
        field.focus.map {
            .focus(field, [])
        }
    }
}
