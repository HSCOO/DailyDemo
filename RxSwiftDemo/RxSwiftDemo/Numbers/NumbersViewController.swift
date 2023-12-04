//
//  NumbersViewController.swift
//  RxSwiftDemo
//
//  Created by This is a good guy on 2023/12/4.
//  Copyright © 2023 HSCOO. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NumbersViewController:UIViewController{
    @IBOutlet weak var textfield1: UITextField!
    
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var resLabel: UILabel!
    @IBOutlet weak var textfield3: UITextField!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(textfield1.rx.text.orEmpty,
                                 textfield2.rx.text.orEmpty,
                                 textfield3.rx.text.orEmpty){ textValue1,textValue2,textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
         .map{$0.description}
         .bind(to: resLabel.rx.text)
         .disposed(by: disposeBag)
    }
}
