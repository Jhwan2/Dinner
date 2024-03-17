//
//  AppFlow.swift
//  Dinner
//
//  Created by 주환 on 3/17/24.
//

import RxFlow
import RxCocoa
import RxSwift
import UIKit

final class AppFlow: Flow {
    let window: UIWindow!
  
    init(window: UIWindow) {
        self.window = window
    }
    
    var root: Presentable {
        return self.window
    }
    
    func navigate(to step: Step) -> FlowContributors {
        print(#function)
        guard let step = step as? AppSteps else { return FlowContributors.none }
        switch step {
        case .homeIsRequired :
            return navigateToHomeFlow()
        case .detailIsRequired :
            return navigateToDetailFlow()
        }
    }
    
    private func navigateToHomeFlow() -> FlowContributors {
        print(#function)
        let viewModel = ArticleViewModel()
        let mainFlow = MainFlow(viewModel: viewModel)
        Flows.use(mainFlow, when: .created) { root in
            self.window.rootViewController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: mainFlow, withNextStepper: viewModel))
    }
        
    private func navigateToDetailFlow() -> FlowContributors {
        return .none
    }

}
