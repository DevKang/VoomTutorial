//
//  CreateWorkoutUseCase.swift
//  VoomTutorial
//
//  Created by KANG HEE JONG on 2020/09/12.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import Foundation
import RxSwift

// 새로운 운동정보를 추가합니다.
class CreateWorkoutUseCase: UseCase {
    typealias ResultValue = Workout
    
    struct RequestValue {
        let name: String
        let bodyPart: BodyPart
        let muscle: String
        let category: WorkoutCategory
    }
    
    private let requestValue: RequestValue
    private let workoutRepository: WorkoutRepository
    
    init(requestValue: RequestValue,
         workoutRepository: WorkoutRepository) {
        self.requestValue = requestValue
        self.workoutRepository = workoutRepository
    }
    
    func start() -> Observable<ResultValue> {
        return self.workoutRepository.create(
            bodyPart: self.requestValue.bodyPart,
            muscle: self.requestValue.muscle,
            category: self.requestValue.category,
            name: self.requestValue.name)
            
    }
}
