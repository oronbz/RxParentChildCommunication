//
//  ViewController.swift
//  RxParentChildCommunication
//
//  Created by Oron Ben Zvi on 8/2/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = RxTableViewSectionedReloadDataSource<ChildSection>()
    private let disposeBag = DisposeBag()
    
    private let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        dataSource.configureCell = { _, tableView, indexPath, viewModel in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as! ChildCellView
            cell.viewModel = viewModel
            return cell
        }
        
        viewModel.sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }


}

