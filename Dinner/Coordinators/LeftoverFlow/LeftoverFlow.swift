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

class LeftoverFlow: Flow { //남은재료Flow
    
    private var navigationController = UINavigationController()
    
    let viewModel: LeftoverViewModel //구색맞추기용 + Stepper역할
    
    init(viewModel: LeftoverViewModel) {
        self.viewModel = viewModel
    }
    
    var root: Presentable {
        return self.navigationController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? LeftoverStep else { return .none }
        navigationController.navigationItem.title = "LeftFlow"
        switch step {
        case .leftoverHomeIsRequired:
            return homeVCPresent()
        case .leftoverNextIsRequired:
            return nextVCPresent()
            
        }
    }
    
    private func homeVCPresent() -> FlowContributors {
        print(#function)
        let vc = DetailViewController() // 테스트용 VC
        self.navigationController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: OneStepper(withSingleStep: LeftoverStep.leftoverHomeIsRequired)))
    }
    
    private func nextVCPresent() -> FlowContributors {
        let vc = DetailViewController()
        vc.view.backgroundColor = .white
        self.navigationController.present(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: viewModel))
    }
}
