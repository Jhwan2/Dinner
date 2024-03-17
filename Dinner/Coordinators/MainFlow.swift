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

class MainFlow: Flow {
    
    let navigationController = UINavigationController()
    
    let viewModel: ArticleViewModel
    
    init(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
    }
    
    var root: Presentable {
        return self.navigationController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppSteps else { return .none }
        switch step {
        case .homeIsRequired:
            return homeVCPresent()
        case .detailIsRequired(let article):
            return detailVCPresent(article: article)
            
        }
    }
    
    private func homeVCPresent() -> FlowContributors {
        print(#function)
        let vc = ViewController.instantiate(withViewModel: ArticleViewModel())
        vc.bind(viewModel)
        self.navigationController.viewControllers.append(vc)
        return .none
    }
    
    private func detailVCPresent(article: Article) -> FlowContributors {
//        let detailViewModel = DetailViewModel(title: article.title)
//        var vc = DetailViewController(viewModel: detailViewModel)
////        vc.bind(viewModel: detailViewModel)
//        self.navigationController.pushViewController(vc, animated: true)
        return .none
    }
}
