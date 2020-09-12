//
//  Entity.swift
//  VoomTutorial
//
//  Created by KANG HEE JONG on 2020/09/12.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import Foundation

protocol Entity: Identifiable, Equatable {
    typealias Identifier = String
}

protocol ValueObject: Equatable { }
