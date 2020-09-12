//
//  QueryWorkoutUseCaseTests.swift
//  VoomTutorialTests
//
//  Created by KANG HEE JONG on 2020/09/12.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import XCTest
@testable import VoomTutorial

class QueryWorkoutUseCaseTests: XCTestCase {
    
    class WorkoutRepositoryMock: WorkoutRepository {
        let backWorkouts:[Workout] = [
            Workout(
                id: UUID().uuidString,
                target: WorkoutTarget(part: .back, muscle: "광배근"),
                category: .machine,
                name: "친업"),
            
            Workout(
                id: UUID().uuidString,
                target: WorkoutTarget(part: .back, muscle: "척추기립근"),
                category: .machine,
                name: "스모 데드리프트"),
            
            Workout(
                id: UUID().uuidString,
                target: WorkoutTarget(part: .back, muscle: "광배근"),
                category: .machine,
                name: "렛 풀 다운"),
            
            Workout(
                id: UUID().uuidString,
                target: WorkoutTarget(part: .back, muscle: "척추기립근"),
                category: .machine,
                name: "백 익스텐션"),
            
            Workout(
                id: UUID().uuidString,
                target: WorkoutTarget(part: .back, muscle: "광배근"),
                category: .machine,
                name: "시티드 로우"),
        ]
        func workouts(by bodyPart: BodyPart, completion: ([Workout]) -> Void) throws -> Cancellable? {
            completion(self.backWorkouts)
            return nil
        }
    }
    
    func testQueryWorkoutUsecaseShouldNotBeEmptyAndGenerateArrangedWorkoutsByMuscleName() {
        // Given
        let expectation = self.expectation(description: "근육별로 운동이 정렬됩니다")
        expectation.expectedFulfillmentCount = 2
        let repository = WorkoutRepositoryMock()
        
        // When
        let bodyPart = BodyPart.back
        // 리포지토리에서 받은 Workout의 카운트를 수령한다
        var countOnRepository = -1
        let _ = try? repository.workouts(by: bodyPart) { workouts in
            countOnRepository = workouts.count
            expectation.fulfill() // 첫번째 fulfill
        }
        
        let requestValue = QueryWorkoutUseCase.RequestValue(bodyPart: bodyPart)
        var arragedWorkouts: [QueryWorkoutUseCase.ArrangedWorkout] = []
        let useCase = QueryWorkoutUseCase(
            requestValue: requestValue,
            completion: { result in
                switch result {
                case .success(let data):
                    arragedWorkouts = data
                case .failure:
                    break
                }
                expectation.fulfill() // 두번째 fulfill
            },
            workoutRepository: repository)
        
        let _ = useCase.start()
        waitForExpectations(timeout: 5, handler: nil)
        
        // Then
        var result = true
        arragedWorkouts.forEach { data in
            data.workouts.forEach { workout in
                if workout.target?.muscle != data.muscle {
                    result = false
                }
            }
        }
        // 1. 빈 배열이 아니라면
        XCTAssertTrue(!arragedWorkouts.isEmpty)
        // 2. 한 ArragedWorkout의 workouts에는 같은 타겟들만 존재 해야 한다
        XCTAssertTrue(result)
        // 3. 레포지토리에서 받은 Workout의 갯수와 UseCase를 통해 받은 ArrangedWorkout의 workouts 갯수의 총합이 같아야 한다
        // -> 누락되는 Workout이 없어야 한다.
        let totalCount = arragedWorkouts.reduce(0, { $0 + $1.workouts.count })
        XCTAssertEqual(totalCount, countOnRepository)
    }
}
