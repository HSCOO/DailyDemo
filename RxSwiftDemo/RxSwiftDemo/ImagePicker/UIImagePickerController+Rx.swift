//
//  UIImagePickerController+Rx.swift
//  RxSwiftDemo
//
//  Created by This is a good guy on 2023/12/1.
//  Copyright © 2023 HSCOO. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIImagePickerController{
    public var didFinishPickingMediaWithInfo: Observable<[UIImagePickerController.InfoKey: AnyObject]>{
        return delegate
            .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:)))
            .map { a in
                return try castOrThrow(Dictionary<UIImagePickerController.InfoKey, AnyObject>.self, a[1])
            }
    }
    
    
    public var didCancel: Observable<()>{
        return delegate
            .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:)))
            .map { _ in}
    }
}

private func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T{
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}
