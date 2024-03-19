//
//  AppFlow.swift
//  Dinner
//
//  Created by 주환 on 3/17/24.
//

import RxFlow
import UIKit

final class AppFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppSteps else { return .none }
        rootViewController.navigationItem.title = "AppFlow"
        switch step {
        case .homeIsRequired:
            return navigateToHomeFlow()
        case .OnboardingIsRequired:
            return navigateToOnboardingFlow()
        }
    }
    
    private func navigateToHomeFlow() -> FlowContributors {
        
        let homeFlow = HomeFlow()
        Flows.use(homeFlow, when: .created) { [unowned self] root in
            guard let root = root as? UINavigationController else { return }
            self.rootViewController = root
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: HomeSteps.homeIsRequired)))
    }
        
    private func navigateToOnboardingFlow() -> FlowContributors {
//        let viewModel = ArticleViewModel()
//        let mainFlow = MainFlow(viewModel: viewModel)
//        Flows.use(mainFlow, when: .created) { root in
//            self.window.rootViewController = root
//        }
//        return .one(flowContributor: .contribute(withNextPresentable: mainFlow, withNextStepper: viewModel))
        return .none
    }

}
