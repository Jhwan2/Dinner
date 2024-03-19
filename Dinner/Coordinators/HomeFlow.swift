//
//  HomeFlow.swift
//  Dinner
//
//  Created by 주환 on 3/19/24.
//

import RxFlow
import UIKit
import RxCocoa
import RxSwift

final class HomeFlow: Flow {
    var disposeBag = DisposeBag()
    
    var root: Presentable {
        return self.navigationController
    }
    
    private lazy var navigationController = UINavigationController()
    
    
    func navigate(to step: Step) -> RxFlow.FlowContributors {
        guard let step = step as? HomeSteps else { return .none }
        navigationController.navigationItem.title = "HomeFlow"
        switch step {
        case .homeIsRequired:
            return navigateToHomeFlow()
        case .deliveryIsRequired:
            return navigateToDeliveryFlow()
        case .leftoverIsRequired:
            return navigateToLeftoverFlow()
        case .historyIsRequired:
            return .none
        }
    }
    
    private func navigateToHomeFlow() -> FlowContributors {
        print(#function)
        
        let vc = ViewController()
        let viewModel = ArticleViewModel()
        vc.bindViewModel(viewModel: viewModel)
        
        Driver.just("now is Home in HomeFlow")
            .drive(onNext: { st in
                vc.testlabel.text = st
            })
            .disposed(by: disposeBag)
        
        self.navigationController.pushViewController(vc, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: viewModel))
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
            guard let root = root as? UINavigationController else { return print("네비 안넘어감")}
            self.navigationController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: leftoverFlow, withNextStepper: OneStepper(withSingleStep: LeftoverStep.leftoverHomeIsRequired)))
    }
    
    
}
