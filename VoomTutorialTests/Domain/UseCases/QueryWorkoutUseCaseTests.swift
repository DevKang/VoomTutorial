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
    
    private func getSuccessfulUseCaseResult(repository: WorkoutRepository, bodyPart: BodyPart) -> [QueryWorkoutUseCase.ArrangedWorkout] {
        let expectation = self.expectation(description: "UseCase가 성공적으로 데이터를 받아옵니다")
        expectation.expectedFulfillmentCount = 1

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
        
        return arragedWorkouts
    }
    
    func testQueryWorkoutUseCaseShouldNotBeEmpty() {
        // Given
        let repository = WorkoutRepositoryMock()
        let bodyPart = BodyPart.back
        // When
        let arranged = self.getSuccessfulUseCaseResult(repository: repository, bodyPart: bodyPart)
        // Then
        XCTAssertTrue(!arranged.isEmpty)
    }
    
    func testQueryWorkoutUseCaseShouldGenerateArrangedWorkoutsByMuscleName() {
        // Given
        let repository = WorkoutRepositoryMock()
        let bodyPart = BodyPart.back
        // When
        let arranged = self.getSuccessfulUseCaseResult(repository: repository, bodyPart: bodyPart)
        var result = true
        arranged.forEach { data in
            data.workouts.forEach { workout in
                if workout.target?.muscle != data.muscle {
                    result = false
                }
            }
        }
        // Then
        XCTAssertTrue(result)
    }
    
    func testQueryWorkoutUseCaseShouldObtainSameCountWithRepository() {
        // Given
        let repository = WorkoutRepositoryMock()
        let bodyPart = BodyPart.back
        
        let expectation = self.expectation(description: "리포지토리에서 운동 목록을 받아옵니다.")
        expectation.expectedFulfillmentCount = 1
        
        // 리포지토리에서 받은 Workout의 카운트를 수령한다
        var countOnRepository = -1
        let _ = try? repository.workouts(by: bodyPart) { workouts in
            countOnRepository = workouts.count
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        // When
        let arranged = self.getSuccessfulUseCaseResult(repository: repository, bodyPart: bodyPart)
        let countOnUseCase = arranged.reduce(0, { $0 + $1.workouts.count })
        
        XCTAssertEqual(countOnRepository, countOnUseCase)
    }
}
