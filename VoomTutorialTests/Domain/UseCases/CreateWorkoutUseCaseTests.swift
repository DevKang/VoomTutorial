//
//  CreateWorkoutUseCaseTests.swift
//  VoomTutorialTests
//
//  Created by DevKang on 2020/09/29.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import Quick
import Nimble
import RxSwift

@testable import VoomTutorial

class CreateWorkoutUseCaseTests: QuickSpec {
    
    private var repository: WorkoutRepository? = nil
    private var useCase: CreateWorkoutUseCase? = nil
    private var disposeBag: DisposeBag? = nil
    
    override func spec() {
        describe("루틴에 사용할 운동을 등록한다", {
            context("#3 원하는 운동이 없다면 새로운 운동을 생성할 수 있어야 한다", {
                beforeEach {
                    self.repository = WorkoutRepositoryMock()
                    self.disposeBag = DisposeBag()
                }
                it("운동이름과, 운동타겟, 카테고리를 입력하여 새로운 운동을 만들 수 있어야 한다.", closure: {
                    // Given
                    guard let repository = self.repository else { return }
                    let req = CreateWorkoutUseCase.RequestValue(name: "새로운 운동", bodyPart: .core, muscle: "복근", category: .machine)
                    
                    var created: Workout? = nil
                    let useCase = CreateWorkoutUseCase(requestValue: req, workoutRepository: repository)
                    // When
                    useCase.start()
                        .subscribe(onNext: { workout in
                            created = workout
                        })
                        .disposed(by: self.disposeBag!)
                    
                    // Then
                    Nimble.expect(created?.name).toEventually(equal("새로운 운동"))
                    Nimble.expect(created?.target).toEventually(equal(WorkoutTarget(part: .core, muscle: "복근")))
                })
                
                it("동일한 운동 이름이 있을 때 운동 만들기가 실패해야 한다", closure: {
                    // Given
                    guard let repository = self.repository else { return }
                    let req = CreateWorkoutUseCase.RequestValue(name: "크런치", bodyPart: .core, muscle: "복근", category: .machine)
                    
                    var error: Error? = nil
                    let useCase = CreateWorkoutUseCase(requestValue: req, workoutRepository: repository)
                    
                    // When
                    useCase.start()
                        .subscribe(onError: { err in
                            error = err
                        })
                        .disposed(by: self.disposeBag!)
                    
                    Nimble.expect((error as NSError?)?.code).toEventually(equal(1))
                })
                
                afterEach {
                    self.repository = nil
                }
            })
        })
    }
}
