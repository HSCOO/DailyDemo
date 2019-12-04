//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by hscai on 2019/12/4.
//  Copyright © 2019 HSCOO. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    @IBOutlet weak var userNameOutlet: UITextField!
    @IBOutlet weak var usenameValidOutlet: UILabel!

    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!

    @IBOutlet weak var doSomethingOutlet: UIButton!

    private var viewModel: SimpleValidationViewModel!

    let minimalUsernameLength = 5
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


//        let usernameValid = userNameOutlet.rx.text.orEmpty
//            .map{ $0.count >= 5}
//            .share(replay: 1, scope: .forever)
//
//        let passwordValid = passwordOutlet.rx.text.orEmpty
//            .map{ $0.count >=  5}
//            .share(replay: 1, scope: .forever)
//
//        let everythingValid = Observable.combineLatest(usernameValid, passwordValid){ $0 && $1}
//            .share(replay: 1, scope: .forever)
//
//        usernameValid.bind(to: passwordOutlet.rx.isEnabled)//用户名是否有效 -> 直接影响密码输入框是否可用
//            .disposed(by: disposeBag)
//        usernameValid.bind(to: usenameValidOutlet.rx.isHidden)//用户名是否有效 -> 直接影响用户提示语是否显示
//            .disposed(by: disposeBag)
//
//        passwordValid.bind(to: passwordValidOutlet.rx.isHidden)
//        .disposed(by: disposeBag)
//
//        everythingValid.bind(to: doSomethingOutlet.rx.isEnabled)//两个消息是否都有效 -> 直接影响按钮是否可以点击
//        .disposed(by: disposeBag)
//
//        doSomethingOutlet.rx.tap
//            .subscribe(onNext: { [weak self] in self?.showAlert()})
//            .disposed(by: disposeBag)
        
        viewModel = SimpleValidationViewModel(username: userNameOutlet.rx.text.orEmpty.asObservable(), password: passwordOutlet.rx.text.orEmpty.asObservable())

        viewModel.usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        viewModel.usernameValid
            .bind(to: usenameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)

        doSomethingOutlet.rx.tap
            .subscribe(onNext: {[weak self] in self?.showAlert()})
            .disposed(by: disposeBag)
    }

    func showAlert() {
        let alertController = UIAlertController.init(title: "RxExample", message: "This is wonderful", preferredStyle: .alert)
        present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    func getRepo(_ repo: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create { (single) -> Disposable in
            let url = URL(string: "https://api.github.com/repos)")!
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error{
                    single(.error(error))
                    return
                }

                guard   let data = data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                        let result = json as? [String: Any] else{
//                            single(.error)
                            return
                        }
                single(.success(result))
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

