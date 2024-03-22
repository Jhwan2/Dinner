//
//  AppSetpper.swift
//  Dinner
//
//  Created by 주환 on 3/17/24.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa

final class AppStepper: Stepper {
    var steps: PublishRelay<Step> = .init()
    var initialStep: Step {
        return AppSteps.homeIsRequired // 불렷을 때 처음으로 소환되는 Step
    }
    func readyToEmitSteps() {
        
    }
}

//final class TestStepper: Stepper {
//    var steps: PublishRelay<Step> = .init()
//    var initialStep: Step {
//        return AppSteps.homeIsRequired // 불렷을 때 처음으로 소환되는 Step
//    }
//    func readyToEmitSteps() {
//        
//    }
//}
// 밑의 스탭보다 조금 큰단위의 네비게이션 처리 단계
// Stepper는 이렇게 Step를 관리할 객체에게 Stepper 프로토콜을 준수하도록 하면 된다. Stepper 프로토콜에서는 steps라는 PublishRelay가 가장 중요하다. 이곳에서 step을 받기도, Flow로 넘기기도 한다. 내부에서 step을 방출하는 메소드를 구현할 수도 있는데, 이건 readyToEmitSteps를 통해서 할 수 있다. initialSteps는 listened되었을 때 처음으로 방출하는 step을 의미한다.
