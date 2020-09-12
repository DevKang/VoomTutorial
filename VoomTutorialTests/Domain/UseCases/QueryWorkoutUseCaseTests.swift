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
    
    func testQueryWorkoutUsecaseShouldReorderWorkoutByMuscleName() {
        // Given
        let expectation = self.expectation(description: "근육별로 운동이 정렬됩니다")
        expectation.expectedFulfillmentCount = 1
        let repository = WorkoutRepositoryMock()
        
        // When
        let bodyPart = BodyPart.chest
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
                expectation.fulfill()
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
        // 1. 빈 배열이 아니라면 2. 한 ArragedWorkout의 workouts에는 같은 타겟들만 존재 해야 한다
        XCTAssertTrue(!arragedWorkouts.isEmpty)
        XCTAssertTrue(result)
    }
}
