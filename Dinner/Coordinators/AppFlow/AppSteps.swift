//
//  AppSteps.swift
//  Dinner
//
//  Created by 주환 on 3/17/24.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa

enum AppSteps: Step {
    case homeIsRequired
    case deliveryIsRequired
    case leftoverIsRequired
}
// 하나의 스탭, 작은 뷰처리 단위이고 
// 대략 Step은 독립적으로 유지되어야 한다는 의미다. 이 독립성을 유지하기 위해서 필요를 구체적으로 명시해야 한다. 'showMovieDetail(withId: Int)'와 같은 step은 어떤 특정 영화를 선택하는 행위와 Detail로 가는 행위, 둘 다를 표현하게 된다. 이 경우 사용할 때 모호한 결과나 잘못된 화면 전환을 일으킬 수 있다. 사실 구체적으로 어디로 갈지를 결정하는건 Stepper의 일이 아니라 Flow의 일이다.


