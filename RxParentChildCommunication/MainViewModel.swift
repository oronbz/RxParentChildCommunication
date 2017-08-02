//
//  MainViewModel.swift
//  RxParentChildCommunication
//
//  Created by Oron Ben Zvi on 8/2/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import RxSwift
import RxDataSources

typealias ChildSection = SectionModel<String, ChildCellViewModel>

class MainViewModel: ChildCellDelegate {
    
    private (set) var sections: Observable<[ChildSection]> = .empty()
    
    // CHILD VIEW MODEL DELEGATE
    let childButtonDidTap: PublishSubject<String> = .init()
    
    let disposeBag = DisposeBag()
    
    init() {
        
        let texts = Observable.just(["shai", "oron", "rx"])
        
        sections = texts.map { texts in
            let sectionItems = texts.map { text in
                ChildCellViewModel(text: text, delegate: self)
            }
            
            let section = ChildSection(model: "", items: sectionItems)
            return [section]
        }
        
        childButtonDidTap.subscribe(onNext: { text in
            print("\(text) did tap!")
        }).disposed(by: disposeBag)
    }
}
