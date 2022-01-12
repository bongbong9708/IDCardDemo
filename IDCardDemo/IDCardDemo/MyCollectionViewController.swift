//
//  MyCollectionViewController.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/11.
//

import UIKit
import SnapKit

class MyCollectionViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let exitBtn: UIButton = {
        let button = UIButton()
        button.setTitle("x", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(moveToMain), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "profileCell")
        collectionView.register(QRCodeCollectionViewCell.self, forCellWithReuseIdentifier: "qrcodeCell")
        collectionView.register(AttendanceCollectionViewCell.self, forCellWithReuseIdentifier: "attendanceCell")
        
        configureCollectionView()
        configureExitBtn()
        
//        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = true
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(172 * view.frame.height / 760)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(190 * view.frame.height / 760))
            make.height.equalTo(398 * view.frame.height / 760)
        }
    }
    
    func configureExitBtn() {
        view.addSubview(exitBtn)
        
        exitBtn.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(103 * view.frame.height / 760)
            make.leading.equalToSuperview().offset(154 * view.frame.width / 360)
            make.trailing.equalToSuperview().offset(-(154 * view.frame.width / 360))
            make.height.equalTo(52 * view.frame.height / 760)
        }
    }
    
    
    @objc func moveToMain() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension MyCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.item == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell
//
//            cell.titleLabel.text = "전자사원증"
//
//            return cell
//        } else if indexPath.item == 1 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "qrcodeCell", for: indexPath) as! QRCodeCollectionViewCell
//            cell.titleLabel.text = "출퇴근 체크 QR"
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attendanceCell", for: indexPath) as! AttendanceCollectionViewCell
//
//            return cell
//        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell

        cell.titleLabel.text = "전자사원증"

        return cell
        
    }
}


extension MyCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300 * collectionView.frame.width / 360, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(collectionView.frame.width / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionView.frame.width / 12, bottom: 0, right: collectionView.frame.width / 12)
    }
}
