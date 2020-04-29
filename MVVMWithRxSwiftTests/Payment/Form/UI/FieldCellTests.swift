//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import XCTest
import UIKit
import RxSwift
import RxCocoa
import MVVMWithRxSwift

class FieldCellTests: XCTestCase {

    func test_inputTextField_updatesOnViewModelChange() {
        let (sut, vm) = makeSUT()
        
        XCTAssertEqual(sut.inputTextField.text, "")
        
        vm.text.accept("some text")
        
        XCTAssertEqual(sut.inputTextField.text, "some text")
    }
    
    func test_viewModelText_updatesOnTextFieldChange() {
        let (sut, vm) = makeSUT()
        
        XCTAssertEqual(vm.text.value, "")
        
        sut.inputTextField.text = "some text"
        sut.inputTextField.sendActions(for: .editingChanged)
        
        XCTAssertEqual(vm.text.value, "some text")
    }

    func test_titleLabelText_isViewModelTitleText() {
        let (sut, _) = makeSUT(viewModelTitle: "a title")

        XCTAssertEqual(sut.cellTitleLabel.text, "a title")
    }

    func test_focusButtonTap_sendsViewModelFocusEvent() {
        let (sut, vm) = makeSUT()
        let events = ViewModelEventsSpy(vm)
        
        XCTAssertEqual(events.focusCount, 0)

        sut.focusButton.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(events.focusCount, 1)
    }

    func test_focusButtonTap_startsEditingTextField() {
        let (sut, _) = makeSUT()
        let window = UIWindow()
        window.addSubview(sut)
        
        XCTAssertFalse(sut.inputTextField.isEditing)

        sut.focusButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(sut.inputTextField.isEditing)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(viewModelTitle: String = "") -> (FieldCell, FieldViewModel) {
        let vm = FieldViewModel(title: viewModelTitle)
        let sut = FieldCell()
        sut.setViewModel(vm)
        return (sut, vm)
    }
    
    private class ViewModelEventsSpy {
        private(set) var focusCount = 0
        private let disposeBag = DisposeBag()
        
        init(_ vm: FieldViewModel) {
            vm.focus.subscribe(onNext: { [weak self] state in
                self?.focusCount += 1
            }).disposed(by: disposeBag)
        }
    }
}
