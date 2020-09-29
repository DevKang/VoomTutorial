//
//  QueryWorkoutUseCaseTests.swift
//  VoomTutorialTests
//
//  Created by KANG HEE JONG on 2020/09/12.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import XCTest
import RxSwift
@testable import VoomTutorial

class QueryWorkoutUseCaseTests: XCTestCase {
    
    private func getSuccessfulUseCaseResult(repository: WorkoutRepository, bodyPart: BodyPart) -> [QueryWorkoutUseCase.ArrangedWorkout] {
        let expectation = self.expectation(description: "UseCase가 성공적으로 데이터를 받아옵니다")
        
        expectation.expectedFulfillmentCount = 1

        let requestValue = QueryWorkoutUseCase.RequestValue(bodyPart: bodyPart)
        var arragedWorkouts: [QueryWorkoutUseCase.ArrangedWorkout] = []
        let useCase = QueryWorkoutUseCase(requestValue: requestValue, workoutRepository: repository)
        let disposeBag = DisposeBag()

        useCase.start()
            .subscribe(onNext: { result in
                switch result {
                case .success(let data):
                    arragedWorkouts = data
                case .failure:
                    break
                }
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
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
        let disposeBag = DisposeBag()
        
        let expectation = self.expectation(description: "리포지토리에서 운동 목록을 받아옵니다.")
        expectation.expectedFulfillmentCount = 1
        
        // 리포지토리에서 받은 Workout의 카운트를 수령한다
        var countOnRepository = -1
        repository.workouts(by: bodyPart)
            .subscribe(onNext: { workouts in
                countOnRepository = workouts.count
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        waitForExpectations(timeout: 5, handler: nil)
        
        // When
        let arranged = self.getSuccessfulUseCaseResult(repository: repository, bodyPart: bodyPart)
        let countOnUseCase = arranged.reduce(0, { $0 + $1.workouts.count })
        
        XCTAssertEqual(countOnRepository, countOnUseCase)
    }
}
