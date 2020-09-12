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
        
    }
    
    func testQueryWorkoutUsecaseShouldReorderWorkoutByMuscleName() {
        // Given
        let expectation = self.expectation(description: "근육 별로 운동이 정렬됩니다")
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
        XCTAssertTrue(!arragedWorkouts.isEmpty && result)
    }
}
