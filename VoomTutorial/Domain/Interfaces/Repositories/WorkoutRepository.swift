//
//  WorkoutRepository.swift
//  VoomTutorial
//
//  Created by KANG HEE JONG on 2020/09/12.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import Foundation

// Repository는 Aggregate와 1:1로 매칭 시킵니다.
// https://www.secmem.org/blog/2020/02/19/ddd-aggregate-pattern/
// https://medium.com/@SlackBeck/애그리게잇-하나에-리파지토리-하나-f97a69662f63
// Voom의 Aggregate은 Numbers참조

protocol WorkoutRepository {
    func workouts(by bodyPart: BodyPart, completion: ([Workout]) -> Void) throws -> Cancellable?
}
