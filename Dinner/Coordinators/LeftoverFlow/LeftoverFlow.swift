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
    
    private let navigationController = UINavigationController()
    
    let viewModel: LeftoverViewModel // Stepper역할
    
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
        let vc = LeftoverVC()
        vc.testlabel.text = "@@is leftoverhome vc"
        self.navigationController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: viewModel))
    }
    
    private func nextVCPresent() -> FlowContributors {
        let vc = TestVC()
        vc.view.backgroundColor = .green
        self.navigationController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: viewModel))
    }
}
