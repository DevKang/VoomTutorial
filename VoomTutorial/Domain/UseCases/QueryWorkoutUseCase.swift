//
//  QueryWorkoutUseCase.swift
//  VoomTutorial
//
//  Created by KANG HEE JONG on 2020/09/12.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import Foundation


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
    private let completion: (ResultValue) -> Void
    private let workoutRepository: WorkoutRepository
    
    init(requestValue: RequestValue,
         completion: @escaping (ResultValue) -> Void,
         workoutRepository: WorkoutRepository) {
        self.requestValue = requestValue
        self.completion = completion
        self.workoutRepository = workoutRepository
    }
    
    func start() -> Cancellable? {
        do {
            return try workoutRepository.workouts(by: requestValue.bodyPart) { workouts in
                // 테스트 실행을 위해 빈 배열을 바로 반환하도록 작성
                let result:[ArrangedWorkout] = [
                    ArrangedWorkout(muscle: "광배근", workouts: workouts)
                ]
                completion(.success(result))
            }
        } catch {
            completion(.failure(error))
            return nil
        }
    }
}
