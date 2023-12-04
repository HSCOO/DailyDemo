//
//  GithubSignupViewModel.swift
//  RxSwiftDemo
//
//  Created by hscai on 2019/12/4.
//  Copyright © 2019 HSCOO. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class GithubSignupViewModel{
    
    let validatedUsername: Observable<ValidationResult>
    let validatedPassword: Observable<ValidationResult>
    let validatedPasswordRepeated: Observable<ValidationResult>
    
    let signupEnabled: Observable<Bool>
    let signedIn: Observable<Bool>
    let signingIn: Observable<Bool>
    
    init(validatedUsername: Observable<ValidationResult>, validatedPassword: Observable<ValidationResult>, validatedPasswordRepeated: Observable<ValidationResult>, signupEnabled: Observable<Bool>, signedIn: Observable<Bool>, signingIn: Observable<Bool>) {
        self.validatedUsername = validatedUsername
        self.validatedPassword = validatedPassword
        self.validatedPasswordRepeated = validatedPasswordRepeated
        self.signupEnabled = signupEnabled
        self.signedIn = signedIn
        self.signingIn = signingIn
    }
}
