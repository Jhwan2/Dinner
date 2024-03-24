//
//  AppFlow.swift
//  Dinner
//
//  Created by 주환 on 3/17/24.
//

import RxFlow
import UIKit
import RxCocoa
import RxSwift

final class AppFlow: Flow { // 전체 AppFlow
    var disposeBag = DisposeBag()
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        var navi = UINavigationController()
        navi.navigationBar.largeContentTitle = "ddddd"
        return navi
    }() // 현재 rootViewController 채택
    
    func navigate(to step: Step) -> FlowContributors { // Sence에서 보내준 TestStepper로 인해 초기 homeIsRequired로 날라옴
        guard let step = step as? AppSteps else { return .none }
        rootViewController.navigationItem.title = "AppFlow"
        switch step {
        case .homeIsRequired:
            return navigateToHome()
        case .OnboardingIsRequired:
            return navigateToOnboardingFlow() //추후 온보딩용
        case .deliveryIsRequired:
            return navigateToDeliveryFlow() // 배달음식 추천
        case .leftoverIsRequired:
            return navigateToLeftoverFlow() // 남은 재료기반 추천
        case .historyIsRequired:
            return .none
        }
    }
    
    private func navigateToHome() -> FlowContributors {
        print(#function)
        
        let vc = HomeVC()
        let viewModel = HomeVM()
        vc.bindViewModel(viewModel: viewModel)
        
        Driver.just("now is Home in HomeFlow")
            .drive(onNext: { st in
                vc.testlabel.text = st
            })
            .disposed(by: disposeBag)
        
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: viewModel))
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
    
    private func navigateToLeftoverFlow() -> FlowContributors {
        let viewModel = LeftoverViewModel()
        let leftoverVC = LeftoverVC()
        let leftoverFlow = LeftoverFlow(viewModel: viewModel)
        leftoverVC.bindViewModel(viewModel: viewModel)
        
        Driver.just("now is Home in LeftoverFlow")
            .drive(onNext: { st in
                leftoverVC.testlabel.text = st
            })
            .disposed(by: disposeBag)
        
        Flows.use(leftoverFlow, when: .created) { [unowned self] root in
            self.rootViewController = root as! UINavigationController
        }
        return .one(flowContributor: .contribute(withNextPresentable: leftoverFlow, withNextStepper: viewModel))
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
    
}

