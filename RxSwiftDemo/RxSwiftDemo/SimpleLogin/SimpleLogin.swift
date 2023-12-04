//
//  SimpleLogin.swift
//  RxSwiftDemo
//
//  Created by This is a good guy on 2023/12/4.
//  Copyright © 2023 HSCOO. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

private let minUsernameLength = 5
private let minPasswordLength = 5

class BagViewController: UIViewController {
    var disposeBag = DisposeBag()
}

class SimpleLogin:BagViewController{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameValidLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidLable: UILabel!
    
    @IBOutlet weak var doSomethingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameValidLabel.text = "Username least \(minUsernameLength) char"
        passwordValidLable.text = "Password least \(minPasswordLength) char"
        
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map{ $0.count >= minUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map{ $0.count >= minPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid){ $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLable.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingButton.rx.tap
            .subscribe(onNext: { [weak self]_ in self?.showAlert()})
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
}
