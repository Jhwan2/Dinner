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
    
    private var viewController: UIViewController = LeftoverVC()
    
    let viewModel: LeftoverViewModel // Stepper역할
    
    init(viewModel: LeftoverViewModel) {
        self.viewModel = viewModel
    }
    
    var root: Presentable {
        return self.viewController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? LeftoverStep else { return .none }
//        navigationController.navigationItem.title = "LeftFlow"
        switch step {
        case .leftoverHomeIsRequired:
            return homeVCPresent()
        case .leftoverNextIsRequired:
            return nextVCPresent()
            
        }
    }
    
    private func homeVCPresent() -> FlowContributors {
        print(#function)
//        viewController.testlabel.text = "@@is leftoverhome vc"
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
    }
    
    private func nextVCPresent() -> FlowContributors {
        let vc = TestVC()
        vc.view.backgroundColor = .green
//        self.navigationController.pushViewController(vc, animated: true)
        self.viewController = vc
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: viewModel))
    }
}
