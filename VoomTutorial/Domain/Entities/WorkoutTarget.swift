//
//  WorkoutTarget.swift
//  VoomTutorial
//
//  Created by KANG HEE JONG on 2020/09/12.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import Foundation

enum BodyPart: CaseIterable {
    case chest
    case back
    case leg
    case shoulder
    case arm
    case core
}

struct WorkoutTarget: Entity {
    let id: Identifier
    let part: BodyPart?
    let muscle: String
}

