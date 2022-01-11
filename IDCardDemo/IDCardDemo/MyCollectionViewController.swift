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
        layout.minimumLineSpacing = 40
        layout.sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
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
        
        collectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "profileCell")
        collectionView.register(QRCodeCollectionViewCell.self, forCellWithReuseIdentifier: "qrcodeCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
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
        if indexPath.item % 3 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell
            
            cell.profileImage?.image = UIImage(named: "상봉")

            return cell
        } else if indexPath.item % 3 == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "qrcodeCell", for: indexPath) as! QRCodeCollectionViewCell
            cell.imageView.image = UIImage(named: "상봉")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .green
            return cell
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 15, height: 15)
//    }
}


extension MyCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 80, height: collectionView.frame.height)
    }

//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//
//        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
//        let index: Int
//        if velocity.x > 0 {
//            index = Int(ceil(estimatedIndex))
//        } else if velocity.x < 0 {
//            index = Int(floor(estimatedIndex))
//        } else {
//            index = Int(round(estimatedIndex))
//        }
//
//        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
//    }
}
