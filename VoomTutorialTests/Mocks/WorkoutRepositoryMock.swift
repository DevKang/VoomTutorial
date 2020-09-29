//
//  WorkoutRepositoryMock.swift
//  VoomTutorialTests
//
//  Created by DevKang on 2020/09/29.
//  Copyright © 2020 KANG HEE JONG. All rights reserved.
//

import Foundation
import RxSwift
@testable import VoomTutorial

class WorkoutRepositoryMock: WorkoutRepository {
    func create(bodyPart: BodyPart, muscle: String, category: WorkoutCategory, name: String) -> Observable<Workout> {
        return Observable.create { emitter in
            if self.workouts.map({ $0.name }).contains(name) {
                emitter.onError(NSError(domain: "WorkoutRepository", code: 1, userInfo: nil))
            } else {
                let workout = Workout(id: UUID().uuidString, target: WorkoutTarget(part: bodyPart, muscle: muscle), category: category, name: name)
                self.userCreatedWorkouts += [workout]
                emitter.onNext(workout)
                emitter.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func workouts(by bodyPart: BodyPart) -> Observable<[Workout]> {
        return Observable.create { emitter in
            emitter.onNext(self.workouts.filter({ $0.target?.part == bodyPart }))
            emitter.onCompleted()
            return Disposables.create()
        }
    }
    
    private var workouts: [Workout] {
        return preCreatedWorkouts + userCreatedWorkouts
    }
    
    private var userCreatedWorkouts: [Workout] = []
    
    // 데이터 소스
    private let preCreatedWorkouts:[Workout] = [
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "벤치 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "덤벨 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "인클라인 벤치 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "클로즈 그림 벤치 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "디클라인 벤치 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "머신 벤치 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "푸쉬-업"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "파라렐 바 딥"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "덤벨 플라이"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "인클라인 덤벨 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "인클라인 덤벨 플라이"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "펙 덱 플라이"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .chest, muscle: "대흉근"), category: .machine, name: "케이블 크로스오버 플라이"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "광배근"), category: .machine, name: "친 업"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "광배근"), category: .machine, name: "리버스 친 업"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "광배근"), category: .machine, name: "렛 풀 다운"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "광배근"), category: .machine, name: "백 렛 풀 다운"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "광배근"), category: .machine, name: "클로즈 그립 렛 풀 다운"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "광배근"), category: .machine, name: "시티드 로우"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "광배근"), category: .machine, name: "원암 덤벨 로우"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "광배근"), category: .machine, name: "덤벨 로우"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "광배근"), category: .machine, name: "바벨 로우"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "광배근"), category: .machine, name: "T바 로우"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "척추기립근"), category: .machine, name: "스모 데드리프트"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "척추기립근"), category: .machine, name: "데드리프트"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "척추기립근"), category: .machine, name: "루마니안 데드리프트"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "척추기립근"), category: .machine, name: "트랩바 데드리프트"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "척추기립근"), category: .machine, name: "백 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .back, muscle: "척추기립근"), category: .machine, name: "머신 백 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴사두근"), category: .machine, name: "스쿼트"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴사두근"), category: .machine, name: "프론트 스쿼트"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴사두근"), category: .machine, name: "파워 스쿼트"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴사두근"), category: .machine, name: "인클라인 레그 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴사두근"), category: .machine, name: "핵 스쿼트"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴사두근"), category: .machine, name: "박스 스쿼트"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴사두근"), category: .machine, name: "레그 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴사두근"), category: .machine, name: "런지"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴사두근"), category: .machine, name: "사이드 런지"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴이두근"), category: .machine, name: "라잉 레그컬"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴이두근"), category: .machine, name: "스탠딩 레그 컬"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "대퇴이두근"), category: .machine, name: "스티프-레그드 데드리프트"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "둔근"), category: .machine, name: "바벨 런지"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "둔근"), category: .machine, name: "덤벨 런지"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "둔근"), category: .machine, name: "힙 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "둔근"), category: .machine, name: "케이블 백 킥"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "둔근"), category: .machine, name: "머신 힙 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "둔근"), category: .machine, name: "플로어 힙 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "둔근"), category: .machine, name: "브릿지"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "둔근"), category: .machine, name: "케이블 힙 어브덕션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "둔근"), category: .machine, name: "라잉 립 어브덕션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "둔근"), category: .machine, name: "시티드 머신 힙 어브덕션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "종아리"), category: .machine, name: "스탠딩 카프 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "종아리"), category: .machine, name: "머신 스탠딩 카프 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "종아리"), category: .machine, name: "원-레그 카프레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "종아리"), category: .machine, name: "덩키 카프레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "종아리"), category: .machine, name: "시티드 카프 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .leg, muscle: "종아리"), category: .machine, name: "싯 스쿼트"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "덤벨 숄더 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "백 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "시티드 프론트 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "시티드 덤벨 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "아놀드 프레스"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "밴트오버 래터럴 레이드"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "래터럴 덤벨 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "프론트 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "바벨 프론트 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "얼터네이트 프론트 암 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "사이드 라잉 래터럴 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "로우-풀리 벤트오버 래터럴 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "로우-풀리 래터럴 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .shoulder, muscle: "삼각근"), category: .machine, name: "풀리 익스터널 암 로테이션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "이두근"), category: .machine, name: "덤벨 컬"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "이두근"), category: .machine, name: "덤벨 컨센추레이션 컬"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "이두근"), category: .machine, name: "인클라인 덤벨 컬"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "이두근"), category: .machine, name: "스탠딩 바벨 컬"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "이두근"), category: .machine, name: "머신 컬"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "이두근"), category: .machine, name: "프리쳐 컬"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "이두근"), category: .machine, name: "얼터네이트 덤벨 컬"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "이두근"), category: .machine, name: "해머 컬"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "삼두근"), category: .machine, name: "트라이셉스 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "삼두근"), category: .machine, name: "라잉 트라이셉스 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "삼두근"), category: .machine, name: "라잉 덤벨 트라이셉스 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "삼두근"), category: .machine, name: "원-암 오버헤드 덤벨 트라이셉스 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "삼두근"), category: .machine, name: "트라이셉스 킥백"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "삼두근"), category: .machine, name: "이지-바 트라이셉스 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "삼두근"), category: .machine, name: "트라이셉스 딥"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "삼두근"), category: .machine, name: "트라이셉스 푸시 다운"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "삼두근"), category: .machine, name: "트라이셉스 리버스 푸시 다운(언더그립)"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "삼두근"), category: .machine, name: "원-암 리버스 푸시 다운"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .arm, muscle: "삼두근"), category: .machine, name: "오버헤드 케이블 트라이셉스 익스텐션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "크런치"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "싯-업"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "짐 래더 싯-업"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "칼브스 오버 벤치 싯-업"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "인클라인 벤치 싯-업"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "서스펜디드 벤치 싯-업"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "하이-풀리 크런치"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "머신 크런치"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "리버스 크런치"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "레그 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "인클라인 레그 레이즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "행잉 레그 레즈"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "트렁크 로테이션"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "덤벨 사이드 밴드"),
        Workout(id: UUID().uuidString, target: WorkoutTarget(part: .core, muscle: "복근"), category: .machine, name: "로망 체어 사이드 밴드"),
    ]
}
