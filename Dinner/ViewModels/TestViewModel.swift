//
//  TestViewModel.swift
//  Dinner
//
//  Created by 주환 on 3/17/24.
//

import RxFlow
import RxCocoa
import RxSwift
import UIKit

class HomeVM: Stepper {
    
    var steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return AppSteps.homeIsRequired
    }
    
//    lazy var detailAction: Action<Article, Void> = {
//        return Action { [weak self] article in
//            
//            self?.steps.accept(AppSteps.detailIsRequired(article))
//            
//            return Observable.empty()
//        }
//    }()
    
    //...
}
