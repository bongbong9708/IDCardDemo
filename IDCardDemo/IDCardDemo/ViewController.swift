//
//  ViewController.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/10.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let collectionBtn: UIButton = {
        let button = UIButton()
        button.setTitle("컬렉션뷰", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(moveToCollection), for: .touchUpInside)
        return button
    }()
    
    let scrollViewBtn: UIButton = {
        let button = UIButton()
        button.setTitle("스크롤타입변경 예정", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(moveToScroll), for: .touchUpInside)
        return button
    }()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureCollectionBtn()
        configureScrollBtn()
    }

    // MARK: - 레이아웃 설정
    func configureCollectionBtn() {
        view.addSubview(collectionBtn)
        
        collectionBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func configureScrollBtn() {
        view.addSubview(scrollViewBtn)
        
        scrollViewBtn.snp.makeConstraints { make in
            make.top.equalTo(collectionBtn.snp.bottom).offset(200)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    // MARK: - Modal버튼 함수 설정
    
    @objc func moveToCollection() {
        let myColVC = MyCollectionViewController()
        myColVC.definesPresentationContext = true
        myColVC.view.backgroundColor = .lightGray .withAlphaComponent(0.4)
        myColVC.modalPresentationStyle = .overCurrentContext
        self.present(myColVC, animated: true, completion: nil)
    }
    
    @objc func moveToScroll() {
        let myScrollVC = MyScrollViewController()
        myScrollVC.definesPresentationContext = true
        myScrollVC.view.backgroundColor = .lightGray .withAlphaComponent(0.4)
        myScrollVC.modalPresentationStyle = .overCurrentContext
        self.present(myScrollVC, animated: true, completion: nil)
    }
}

