//
//  QueryWorkoutUseCase.swift
//  VoomTutorial
//
//  Created by KANG HEE JONG on 2020/09/12.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import Foundation
import RxSwift

// 운동 타겟의 부위를 입력하면 근육별로 정렬된 운동의 리스트를 불러올 수 있어야 한다
class QueryWorkoutUseCase: UseCase {
    
    struct RequestValue {
        let bodyPart: BodyPart
    }
    
    // 근육 이름 + 해당하는 운동 리스트
    struct ArrangedWorkout {
        let muscle: String
        let workouts: [Workout]
    }
    
    typealias ResultValue = (Result<[ArrangedWorkout], Error>)

    private let requestValue: RequestValue
    private let workoutRepository: WorkoutRepository
    
    init(requestValue: RequestValue,
         workoutRepository: WorkoutRepository) {
        self.requestValue = requestValue
        self.workoutRepository = workoutRepository
    }
    
    func start() -> Observable<ResultValue> {
        return workoutRepository
            .workouts(by: requestValue.bodyPart)
            .map { workouts in
                let muscles: [String] = workouts
                    .map { $0.target?.muscle }
                    .filter { $0 != nil }
                    .map { $0! }
                let reduced = Array(Set(muscles)).sorted()
                let result: [ArrangedWorkout] = reduced
                    .map { muscle in
                        return ArrangedWorkout(muscle: muscle, workouts: workouts.filter({ $0.target?.muscle == muscle}))
                    }
                return .success(result)
            }
    }
}
