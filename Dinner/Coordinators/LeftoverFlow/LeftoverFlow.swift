//
//  MainFlow.swift
//  Dinner
//
//  Created by 주환 on 3/17/24.
//

import UIKit
import RxCocoa
import RxSwift
import RxFlow

class LeftoverFlow: Flow {
    
    let navigationController = UINavigationController()
    
    let viewModel: LeftoverViewModel
    
    init(viewModel: LeftoverViewModel) {
        self.viewModel = viewModel
    }
    
    var root: Presentable {
        return self.navigationController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? LeftoverStep else { return .none }
        switch step {
        case .leftoverHomeIsRequired:
            return homeVCPresent()
        case .leftoverNextIsRequired:
            return nextVCPresent()
            
        }
    }
    
    private func homeVCPresent() -> FlowContributors {
        let disposeBag = DisposeBag()
        print(#function)
        let vc = ViewController()
//        vc.bindViewModel(viewModel: viewModel)
        Driver.just("now is home in Leftover")
            .drive { st in
                vc.testlabel.text = st
            }.disposed(by: disposeBag)
        self.navigationController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: viewModel))
    }
    
    private func nextVCPresent() -> FlowContributors {
        let vc = DetailViewController()
        vc.view.backgroundColor = .white
        self.navigationController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: viewModel))
    }
}
