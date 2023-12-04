//
//  SimpleValidationViewModel.swift
//  RxSwiftDemo
//
//  Created by hscai on 2019/12/4.
//  Copyright © 2019 HSCOO. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

let minimalUsernameLength = 5

class SimpleValidationViewModel {
    let usernameValid: Observable<Bool>
    let passwordValid: Observable<Bool>
    let everythingValid: Observable<Bool>

    init(username:Observable<String>, password:Observable<String>) {
        usernameValid = username
            .map{ $0.count >= minimalUsernameLength}
            .share(replay: 1, scope: .forever)
        
        passwordValid = password
        .map{ $0.count >= minimalUsernameLength}
        .share(replay: 1, scope: .forever)
        
        everythingValid = Observable.combineLatest(usernameValid, passwordValid){$0 && $1}
            .share(replay: 1, scope: .forever)
    }
}
