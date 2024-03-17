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
    let navigation = UINavigationController()
    var viewMdoel = ArticleViewModel()
    init(window: UIWindow) {
        self.window = window
    }
    
    var root: Presentable {
        return self.navigation
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
//        let viewModel = ArticleViewModel()
//        let mainFlow = MainFlow(viewModel: viewModel)
//        Flows.use(mainFlow, when: .created) { root in
//            self.window.rootViewController = root
//        }
        let vc = ViewController()
        vc.bindViewModel(viewModel: self.viewMdoel)
//        self.window.rootViewController
        self.navigation.setViewControllers([vc], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: self.viewMdoel))
    }
        
    private func navigateToDetailFlow() -> FlowContributors {
        let vc = DetailViewController()
        self.navigation.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: self.viewMdoel))
    }

}
