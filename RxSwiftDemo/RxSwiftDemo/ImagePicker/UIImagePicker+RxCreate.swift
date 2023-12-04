//
//  UIImagePicker+RxCreate.swift
//  RxSwiftDemo
//
//  Created by This is a good guy on 2023/12/1.
//  Copyright © 2023 HSCOO. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


func dismissViewController(_ viewController: UIViewController, animated:Bool) {
    if viewController.isBeingDismissed || viewController.isBeingPresented{
        DispatchQueue.main.async {
            dismissViewController(viewController, animated: animated)
        }
        return
    }
    if viewController.presentedViewController != nil{
        viewController.dismiss(animated: animated)
    }
}

extension Reactive where Base: UIImagePickerController{
    static func createWithParent(_ parent: UIViewController?, 
                                 animated: Bool = true,
                                 configureImagePicker: @escaping (UIImagePickerController) throws -> Void = {x in}) -> Observable<UIImagePickerController>{
        return Observable.create { [weak parent] observer in
            let imagePicker = UIImagePickerController()
            let dismissDisposable = imagePicker.rx
                .didCancel
                .subscribe({ [weak imagePicker] _ in
                    guard let imagePicker = imagePicker else { return }
                    dismissViewController(imagePicker, animated: animated)
                })
            do{
               try configureImagePicker(imagePicker)
            }
            
            catch let error{
                observer.on(.error(error))
                return Disposables.create()
            }
            
            guard let parent else{
                observer.on(.completed)
                return Disposables.create()
            }
            
            parent.present(imagePicker, animated: animated)
            observer.on(.next(imagePicker))
            
            return Disposables.create(dismissDisposable, Disposables.create {
                dismissViewController(imagePicker, animated: animated)
            })
        }
    }
}
