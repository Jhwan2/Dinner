//
//  ViewController.swift
//  TestProject
//
//  Created by 주환 on 3/15/24.
//

import UIKit
import Reusable
import RxFlow
import RxSwift
import RxCocoa
import Then
import SnapKit

class ViewController: UIViewController, ViewModelBased {
    
    let testlabel = UILabel()
    
    var viewModel: ArticleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testlabel.do {
            $0.text = "@@@@@@@@@@@"
        }
        self.testlabel.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
        }
        view.backgroundColor = .blue
    }
    
    func bindViewModel(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
    }

}

