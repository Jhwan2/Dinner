//
//  LeftoverStep.swift
//  Dinner
//
//  Created by 주환 on 3/18/24.
//

import Foundation
import RxFlow

enum LeftoverStep: Step { // 남은 재료기반 Flow의 Step 선언 (초기)
    case leftoverHomeIsRequired // LeftoverFlow의 첫번째 화면
    case leftoverNextIsRequired // LeftoverFlow의 다음 화면
}
