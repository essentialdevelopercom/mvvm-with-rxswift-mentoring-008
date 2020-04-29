//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import UIKit
import RxSwift

public class FieldCell: UITableViewCell {
    public let inputTextField = UITextField()
    public let cellTitleLabel = UILabel()
    public let focusButton = UIButton()
    
    private var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
        
    public func setViewModel(_ vm: FieldViewModel) {
        vm.text
            .bind(to: inputTextField.rx.text)
            .disposed(by: disposeBag)
        
        inputTextField.rx.text
            .orEmpty
            .skip(1)
            .bind(to: vm.text)
            .disposed(by: disposeBag)

        focusButton.rx.tap
            .bind(to: vm.focus)
            .disposed(by: disposeBag)

        cellTitleLabel.text = vm.title
    }
    
    private func setup() {
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cellTitleLabel)
        
        inputTextField.keyboardType = .default
        inputTextField.inputAccessoryView = nil
        inputTextField.borderStyle = .roundedRect
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(inputTextField)
        
        focusButton.translatesAutoresizingMaskIntoConstraints = false
        focusButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        addSubview(focusButton)
                
        NSLayoutConstraint.activate([
            cellTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            cellTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cellTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            cellTitleLabel.heightAnchor.constraint(equalToConstant: 16),

            inputTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            inputTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            inputTextField.topAnchor.constraint(equalTo: cellTitleLabel.bottomAnchor, constant: 16),
            inputTextField.heightAnchor.constraint(equalToConstant: 50),
            inputTextField.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16),
            
            focusButton.topAnchor.constraint(equalTo: topAnchor),
            focusButton.leftAnchor.constraint(equalTo: leftAnchor),
            focusButton.rightAnchor.constraint(equalTo: rightAnchor),
            focusButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func handleTap() {
        inputTextField.becomeFirstResponder()
    }
}
