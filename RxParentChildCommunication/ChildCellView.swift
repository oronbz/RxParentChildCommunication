//
//  ChildCellView.swift
//  RxParentChildCommunication
//
//  Created by Oron Ben Zvi on 8/2/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChildCellView: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    private var disposeBag: DisposeBag? = DisposeBag()
    
    var viewModel: ChildCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            let disposeBag = DisposeBag()
            
            label.text = viewModel.text
            
            button.rx.tap
                .bind(to: viewModel.buttonDidTap)
                .disposed(by: disposeBag)
            
            self.disposeBag = disposeBag
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
        disposeBag = nil
    }

}
