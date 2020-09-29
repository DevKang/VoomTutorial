//
//  UseCase.swift
//  VoomTutorial
//
//  Created by KANG HEE JONG on 2020/09/12.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import Foundation
import RxSwift

protocol UseCase {
    associatedtype ResultValue
    func start() -> Observable<ResultValue>
}
