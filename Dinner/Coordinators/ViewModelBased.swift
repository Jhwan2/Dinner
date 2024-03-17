//
//  ViewModelBased.swift
//  Dinner
//
//  Created by 주환 on 3/17/24.
//

import UIKit
import Reusable

protocol ViewModelBased: AnyObject {
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
    func bindViewModel(viewModel: ArticleViewModel)
}

