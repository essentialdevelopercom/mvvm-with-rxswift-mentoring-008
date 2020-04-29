//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import RxSwift
import RxDataSources

public class PaymentFormViewController: UITableViewController {
    private typealias Section = AnimatableSectionModel<String, CellViewModel>
    
    private var viewModel: PaymentFormViewModel?
    private let disposeBag = DisposeBag()
    
    public convenience init(viewModel: PaymentFormViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.register(FieldCell.self, forCellReuseIdentifier: "FieldCell")
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch item {
            case let .suggestion(vm):
                let cell = UITableViewCell()
                cell.textLabel?.text = vm.text
                return cell
                
            case let .field(vm):
                let cell = tableView.dequeueReusableCell(withIdentifier: "FieldCell") as! FieldCell
                cell.setViewModel(vm)
                return cell
            }
        })
        
        dataSource.animationConfiguration = .init(
            insertAnimation: .fade,
            reloadAnimation: .automatic,
            deleteAnimation: .fade)
        
        let sections: Observable<[Section]> = viewModel.state.map { state in
            switch state {
            case let .fields(fields):
                return [
                    AnimatableSectionModel(
                        model: "Fields",
                        items: fields.map(CellViewModel.field))
                ]
                
            case let .focus(field, suggestions):
                return [
                    AnimatableSectionModel(
                        model: "Fields",
                        items: [.field(field)]),
                    AnimatableSectionModel(
                        model: "Suggestions",
                        items: suggestions.map(CellViewModel.suggestion))
                ]
            }
        }
        
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(CellViewModel.self)
            .subscribe(onNext: { [weak self] model in
                if case let .suggestion(vm) = model {
                    self?.view.endEditing(true)
                    vm.select.accept(())
                }
            })
            .disposed(by: disposeBag)
    }
}
