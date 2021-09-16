//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import XCTest
import RxSwift
import MVVMWithRxSwift

class PaymentFormViewControllerIntegrationTests: XCTestCase {
    
    func test_initialState_showsFieldCells() {
        let (sut, vm) = makeSUT()
        let state = ViewModelStateSpy(vm.state)
                
        assert(sut, isShowingAllFieldsFor: state.current)
    }
    
    func test_focusOnField_showsOnlyFocusedFieldCell() {
        let (sut, vm) = makeSUT()
        let state = ViewModelStateSpy(vm.state)

        sut.focusOnFieldCell(inSection: 0, atIndex: 0)

        assert(sut, isShowingSingleFieldWithSuggestions: [], for: state.current)
    }
    
    func test_enterTextOnFocusedField_showsFocusedFieldWithSuggestionCells() {
        let service = SuggestionsServiceStub()
        let (sut, vm) = makeSUT(service: service)
        let state = ViewModelStateSpy(vm.state)

        sut.focusOnFieldCell(inSection: 0, atIndex: 0)
        sut.enterTextOnFieldCell(service.stub.query, inSection: 0, atIndex: 0)

        assert(sut, isShowingSingleFieldWithSuggestions: service.stub.suggestions, for: state.current)
    }
    
    func test_selectSuggestionCell_showsAllFields() {
        let service = SuggestionsServiceStub()
        let (sut, vm) = makeSUT(service: service)
        let state = ViewModelStateSpy(vm.state)

        sut.focusOnFieldCell(inSection: 0, atIndex: 0)
        sut.enterTextOnFieldCell(service.stub.query, inSection: 0, atIndex: 0)
        sut.selectSuggestion(inSection: 1, atIndex: 0)
        
        assert(sut, isShowingAllFieldsFor: state.current)
    }

    // MARK: - Helpers
    
    private func makeSUT(service: SuggestionsServiceStub = .init()) -> (PaymentFormViewController, PaymentFormViewModel) {
        let vm = PaymentFormViewModel(service: service)
        let sut = PaymentFormViewController(viewModel: vm)
		sut.view.frame = iPhone12Frame
        return (sut, vm)
    }
	
	private var iPhone12Frame: CGRect {
		CGRect(x: 0, y: 0, width: 585, height: 1266)
	}
    
    private class ViewModelStateSpy {
        private(set) var current: PaymentFormViewModel.State?
        private let disposeBag = DisposeBag()
        
        init(_ observable: Observable<PaymentFormViewModel.State>) {
            observable.subscribe(onNext: { [weak self] state in
                self?.current = state
            }).disposed(by: disposeBag)
        }
    }
    
    private func assert(_ sut: PaymentFormViewController, isShowingAllFieldsFor state: PaymentFormViewModel.State?, file: StaticString = #file, line: UInt = #line) {
        guard case let .fields(fields) = state else {
            return XCTFail("Expected .fields state", file: file, line: line)
        }
        
        XCTAssertEqual(sut.numberOfSections(), 1, "Expected one section", file: file, line: line)
        XCTAssertEqual(sut.numberOfCells(inSection: 0), fields.count, "Expected cells for every field in the first section", file: file, line: line)
        
        fields.enumerated().forEach { (index, field) in
            let cell = sut.cell(inSection: 0, atIndex: index) as? FieldCell
            XCTAssertEqual(cell?.cellTitleLabel.text, field.title, "Wrong cell title for field at index \(index)", file: file, line: line)
            XCTAssertEqual(cell?.inputTextField.text, field.text.value, "Wrong cell text for field at index \(index)", file: file, line: line)
        }
    }
    
    private func assert(_ sut: PaymentFormViewController, isShowingSingleFieldWithSuggestions expectedSuggestions: [Suggestion], for state: PaymentFormViewModel.State?, file: StaticString = #file, line: UInt = #line) {
        guard case let .focus(field, suggestions) = state else {
            return XCTFail("Expected .focus state")
        }
        
        XCTAssertEqual(sut.numberOfSections(), 2, "Expected two sections", file: file, line: line)
        XCTAssertEqual(sut.numberOfCells(inSection: 0), 1, "Expected one field cell in the first section", file: file, line: line)
        XCTAssertEqual(sut.numberOfCells(inSection: 1), expectedSuggestions.count, "Expected cells for every suggestion in the second session", file: file, line: line)

        let fieldCell = sut.cell(inSection: 0, atIndex: 0) as? FieldCell
        XCTAssertEqual(fieldCell?.cellTitleLabel.text, field.title, "Wrong cell title for focused field")
        XCTAssertEqual(fieldCell?.inputTextField.text, field.text.value, "Wrong cell text for focused field")

        suggestions.enumerated().forEach { (index, suggestion) in
            let suggestionCell = sut.cell(inSection: 1, atIndex: index)
            XCTAssertEqual(suggestionCell?.textLabel?.text, suggestion.text, "Wrong cell text for suggestion at index \(index)", file: file, line: line)
        }
    }
    
}

private extension PaymentFormViewController {
    func numberOfSections() -> Int {
        tableView.numberOfSections
    }
    
    func numberOfCells(inSection section: Int) -> Int {
        tableView.numberOfRows(inSection: section)
    }
    
    func cell(inSection section: Int, atIndex index: Int) -> UITableViewCell? {
        tableView.cellForRow(at: IndexPath(row: index, section: section))
    }
    
    func focusOnFieldCell(inSection section: Int, atIndex index: Int) {
        let firstFieldCell = cell(inSection: section, atIndex: index) as? FieldCell
        firstFieldCell?.focusButton.sendActions(for: .touchUpInside)
    }
    
    func enterTextOnFieldCell(_ text: String, inSection section: Int, atIndex index: Int) {
        let firstFieldCell = cell(inSection: section, atIndex: index) as? FieldCell
        firstFieldCell?.inputTextField.text = text
        firstFieldCell?.inputTextField.sendActions(for: .editingChanged)
    }
    
    func selectSuggestion(inSection section: Int, atIndex index: Int) {
        tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: index, section: section))
    }
}
