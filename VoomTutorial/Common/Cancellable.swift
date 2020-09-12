//
//  Cancellable.swift
//  VoomTutorial
//
//  Created by KANG HEE JONG on 2020/09/12.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import Foundation

// 도중에 취소할 수 있는 작업을 정의할 때 사용합니다.
// cancel()을 호출하면 해당 작업을 중지하도록 구현합니다.
public protocol Cancellable {
    func cancel()
}

