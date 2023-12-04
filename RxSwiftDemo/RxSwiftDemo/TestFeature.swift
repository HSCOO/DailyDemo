//
//  TestFeature.swift
//  RxSwiftDemo
//
//  Created by This is a good guy on 2023/12/1.
//  Copyright © 2023 HSCOO. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TestFeature:UIView{
    let disposeBag = DisposeBag()
    init() {
        super.init(frame: .zero)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.rx.tap
            .subscribe({_ in
                print("click")
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
