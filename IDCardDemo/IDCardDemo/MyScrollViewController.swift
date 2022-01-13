//
//  MyScrollViewController.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/11.
//

import UIKit

class MyScrollViewController: UIViewController {
    
    // MARK: - 뷰 생성
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()
    
    let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 3
        page.currentPage = 0
        
        page.pageIndicatorTintColor = UIColor(displayP3Red: 193/255, green: 200/255, blue: 214/255, alpha: 1)
        page.currentPageIndicatorTintColor = UIColor(displayP3Red: 96/255, green: 127/255, blue: 255/255, alpha: 1)
        
        page.addTarget(self, action: #selector(movePage), for: .valueChanged)
        
        return page
    }()
    
    let exitBtn: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(moveToMain), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 26
        return button
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 컬렉션뷰셀 등록
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "profileCell")
        collectionView.register(QRCodeCollectionViewCell.self, forCellWithReuseIdentifier: "qrcodeCell")
        collectionView.register(AttendanceCollectionViewCell.self, forCellWithReuseIdentifier: "attendanceCell")
        
        // 레이아웃
        configureCollectionView()
        configureExitBtn()
        configurePageControll()
        
    }
    
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
    // 뷰가 생성된 직후 indexPath.item == 1, QR코드 화면으로 이동
        super.viewDidAppear(animated)
        let indexPath: IndexPath = IndexPath(row: 1, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    // MARK: - 서브뷰 추가 및 레이아웃 설정
    func configureCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(172 * view.frame.height / 760)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(406)
        }
    }
    
    func configureExitBtn() {
        view.addSubview(exitBtn)
        
        exitBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(52)
            make.top.equalTo(collectionView.snp.bottom).offset(106)
        }
    }
    
    func configurePageControll() {
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
    }
    
    
    
    // MARK: - objc 함수 설정
    @objc func moveToMain() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func movePage() {
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

}


extension MyScrollViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell

            cell.profileImage.image = UIImage(named: "이상봉")
            cell.teamLabel.text = "더존비즈온 / 모바일Cell팀"
            cell.nameLabel.text = "이상봉"
            
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "qrcodeCell", for: indexPath) as! QRCodeCollectionViewCell
            
//            cell.QRImage.image = UIImage(named: "QR코드")
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attendanceCell", for: indexPath) as! AttendanceCollectionViewCell

            cell.titleLabel.text = "나의 근무시간 관리"
            
            return cell
        }
    }
    
//    coll
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        <#code#>
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
}


extension MyScrollViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 406)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return CGFloat(collectionView.frame.width - 300)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: (collectionView.frame.width - 300) / 2, bottom: 0, right: (collectionView.frame.width - 300) / 2)
//    }

}


// MARK: - pageControll 설정
extension MyScrollViewController: UIScrollViewDelegate {
    
    // 컬렉션뷰를 스크롤하면 반복적으로 호출
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width //
        
        let x = scrollView.contentOffset.x + (width/2)
        
        let newPage = Int(x/width)
        if pageControl.currentPage != newPage {
            pageControl.currentPage = newPage
        }
    }
    
}
