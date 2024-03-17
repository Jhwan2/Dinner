//
//  ViewModels.swift
//  TestProject
//
//  Created by 주환 on 3/15/24.
//

import UIKit
import RxFlow
import RxCocoa
import RxSwift

struct ViewControllerViewModel: Stepper {
    var steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return AppSteps.homeIsRequired
    }
    
    
    
    
}
