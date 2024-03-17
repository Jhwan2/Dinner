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

class ViewController: UIViewController {
    
    let testlabel = UILabel()
    let button = UIButton(type: .system)
    
    var viewModel: ArticleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testlabel.do {
            $0.text = "@@@@@@@@@@@"
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 30)
        }
        self.button.do {
            $0.tintColor = .black
            $0.setTitle("NextVC", for: .normal)
        }
        view.addSubview(testlabel)
        view.addSubview(button)
        self.testlabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(testlabel.snp.bottom).offset(100)
        }
        
        button.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.steps.accept(AppSteps.detailIsRequired)
            }
        
        view.backgroundColor = .blue
    }
    
    func bindViewModel(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
    }

}

