//
//  Workout.swift
//  VoomTutorial
//
//  Created by KANG HEE JONG on 2020/09/12.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import Foundation

enum WorkoutCategory: CaseIterable {
    case machine
    case free
    case cardio
}

struct Workout: Entity {
    let id: Identifier
    let target: WorkoutTarget?
    let category: WorkoutCategory
    let name: String
}
