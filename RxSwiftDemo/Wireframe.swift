//
//  Wireframe.swift
//  RxSwiftDemo
//
//  Created by hscai on 2019/12/4.
//  Copyright © 2019 HSCOO. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

enum RetryResult {
    case retry
    case cancel
}

protocol Wireframe {
    func open(url: URL)
    func promptFor<Action: CustomStringConvertible>(_ message: String, cancelAction: Action, actions: [Action]) -> Observable<Action>
}
