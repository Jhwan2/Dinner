////
////  MainFlow.swift
////  Dinner
////
////  Created by 주환 on 3/17/24.
////
//
//import UIKit
//import RxCocoa
//import RxSwift
//import RxFlow
//
//class MainFlow: Flow {
//    
//    let navigationController = UINavigationController()
//    
//    let viewModel: ArticleViewModel
//    
//    init(viewModel: ArticleViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    var root: Presentable {
//        return self.navigationController
//    }
//    
//    func navigate(to step: Step) -> FlowContributors {
//        guard let step = step as? AppSteps else { return .none }
//        switch step {
//        case .homeIsRequired:
//            return homeVCPresent()
//        case .detailIsRequired:
//            return detailVCPresent()
//            
//        }
//    }
//    
//    private func homeVCPresent() -> FlowContributors {
//        print(#function)
//        let vc = ViewController()
//        vc.bindViewModel(viewModel: viewModel)
//        self.navigationController.setViewControllers([vc], animated: false)
//        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: viewModel))
//    }
//    
//    private func detailVCPresent() -> FlowContributors {
//        let vc = DetailViewController()
////        self.navigationController
//        return .none
//    }
//}
