//
//  AppFlow.swift
//  Dinner
//
//  Created by 주환 on 3/17/24.
//

import RxFlow
import UIKit

final class AppFlow: Flow { // 전체 AppFlow
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController = UINavigationController() // 현재 rootViewController 채택
    
    func navigate(to step: Step) -> FlowContributors { // Sence에서 보내준 TestStepper로 인해 초기 homeIsRequired로 날라옴
        guard let step = step as? AppSteps else { return .none }
        rootViewController.navigationItem.title = "AppFlow"
        switch step {
        case .homeIsRequired:
            return navigateToHomeFlow()
        case .OnboardingIsRequired:
            return navigateToOnboardingFlow() //추후 온보딩용
        }
    }
    
    private func navigateToHomeFlow() -> FlowContributors {
        let homeFlow = HomeFlow() // 원래는 AppFlow = HomeFlow로 하려 했으나 RxFlow 나만의 이유로 이리저리 굴려보기 위해 중간 home Flow 추가
        
        Flows.use(homeFlow, when: .created) { [unowned self] root in // homeFlow 시작 ,
            guard let root = root as? UINavigationController else { return }
            self.rootViewController = root
        } // homeFlow의 root는 현재 homeFlow내의 navigaionController, AppFlow의 rootViewController 에 homeFlow의 navigationController를 할당  < 왜 ?
        // 기본적으로 navigationController하나에 여러개의 viewController를 추가해서 사용하는데 왜 여기선 이렇게 구조가 짜여진거지 ?
        // 내가 짜고 싶은건 AppFlow의 navigationController를 기반으로 여기서 push를 해주고 싶은데 이렇게되면 오 그러면 homeFlow 의 root를 viewcontroller로 사용할 수 없나 ? 될텐데 ,, 해보자
        // 아 flow내부에 navigationController를 가져야 homeFlow에서 그다음것을 이어갈 수 있어 없으면 어떻게 push해 ?
        
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
