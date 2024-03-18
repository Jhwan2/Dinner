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
    private lazy var navigationController = UINavigationController()
    var disposeBag = DisposeBag()
    var viewMdoel = ArticleViewModel()
    
    var root: Presentable {
        return self.navigationController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        print(#function)
        guard let step = step as? AppSteps else { return FlowContributors.none }
        switch step {
        case .homeIsRequired:
            return navigateToHomeFlow()
        case .deliveryIsRequired:
            return navigateToDeliveryFlow()
        case .leftoverIsRequired:
            return navigateToLeftoverFlow()
        }
    }
    
    private func navigateToHomeFlow() -> FlowContributors {
        print(#function)
        
        let vc = ViewController()
        vc.bindViewModel(viewModel: viewMdoel)
        
        Driver.just("now is HomeStep in AppFlow")
            .drive(onNext: { st in
                vc.testlabel.text = st
            })
            .disposed(by: disposeBag)
        
        self.navigationController.pushViewController(vc, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: viewMdoel))
    }
        
    private func navigateToDeliveryFlow() -> FlowContributors {
//        let viewModel = ArticleViewModel()
//        let mainFlow = MainFlow(viewModel: viewModel)
//        Flows.use(mainFlow, when: .created) { root in
//            self.window.rootViewController = root
//        }
//        return .one(flowContributor: .contribute(withNextPresentable: mainFlow, withNextStepper: viewModel))
        return .none
    }
    
    private func navigateToLeftoverFlow() -> FlowContributors {
        let viewModel = LeftoverViewModel()
        let leftoverFlow = LeftoverFlow(viewModel: viewModel)
        Flows.use(leftoverFlow, when: .created) { [unowned self] root in
            DispatchQueue.main.async {
                self.navigationController.pushViewController(root, animated: false)
            }
        }
        return .one(flowContributor: .contribute(withNextPresentable: leftoverFlow, withNextStepper: viewModel))
    }

}
