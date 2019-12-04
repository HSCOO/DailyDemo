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


    init(input:(
        username: Observable<String>,
        password: Observable<String>,
        repeatedPassword: Observable<String>,
        loginTaps: Observable<Void>
        ),
         dependency:(
        API: GitHubAPI,
        validationService: GitHubValidationService,
        wireframe: wiref
        )
    ) {

    }
}
