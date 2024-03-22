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

class HomeVC: UIViewController {
    var disposeBag = DisposeBag()
    
    let testlabel = UILabel()
    let button = UIButton(type: .system)
    let button2 = UIButton(type: .system)
    
    var viewModel: HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testlabel.do {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 20)
        }
        self.button.do {
            $0.setTitle("Leftover", for: .normal)
        }
        self.button2.do {
            $0.setTitle("To home", for: .normal)
        }
        [testlabel, button, button2].forEach {
            view.addSubview($0)
        }
        self.testlabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(testlabel.snp.bottom).offset(100)
        }
        self.button2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button.snp.bottom).offset(50)
        }
        
        button.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.steps.accept(AppSteps.leftoverIsRequired)
                print("leftover 뷰 이동")
            }
            .disposed(by: disposeBag)
        
        button2.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.steps.accept(AppSteps.homeIsRequired)
                print("홈으로")
            }
            .disposed(by: disposeBag)
        
    }
    
    func bindViewModel(viewModel: HomeVM) {
        self.viewModel = viewModel
    }

}

