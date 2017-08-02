//
//  ChildCellViewModel.swift
//  RxParentChildCommunication
//
//  Created by Oron Ben Zvi on 8/2/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import RxSwift

protocol ChildCellDelegate {
    var childButtonDidTap: PublishSubject<String> { get }
}

class ChildCellViewModel {
    
    let buttonDidTap: PublishSubject<Void> = .init()
    let text: String
    
    private let disposeBag = DisposeBag()
    
    init(text: String, delegate: ChildCellDelegate) {
        self.text = text
        
        buttonDidTap
            .map { _ in text }
            .bind(to: delegate.childButtonDidTap)
            .disposed(by: disposeBag)
    }
}
