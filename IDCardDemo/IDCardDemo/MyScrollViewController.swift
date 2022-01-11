//
//  MyScrollViewController.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/11.
//

import UIKit

class MyScrollViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .green
        return scroll
    }()
    
    let exitBtn: UIButton = {
        let button = UIButton()
        button.setTitle("나가기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(moveToMain), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureScrollView()
        configureExitBtn()
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
    }
    
    func configureExitBtn() {
        view.addSubview(exitBtn)
        
        exitBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom).offset(50)
            make.bottom.equalToSuperview().offset(-150)
        }
    }
    
    
    @objc func moveToMain() {
        self.dismiss(animated: true, completion: nil)
    }

}
