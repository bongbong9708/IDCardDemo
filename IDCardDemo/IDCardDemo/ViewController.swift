//
//  ViewController.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/10.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - 버튼생성
    let collectionBtn: UIButton = {
        let button = UIButton()
        button.setTitle("컬렉션뷰", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(moveToCollection), for: .touchUpInside)
        return button
    }()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureCollectionBtn()
    }

    // MARK: - 레이아웃 설정
    func configureCollectionBtn() {
        view.addSubview(collectionBtn)
        
        collectionBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(300)
            make.leading.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().offset(-100)
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
}

