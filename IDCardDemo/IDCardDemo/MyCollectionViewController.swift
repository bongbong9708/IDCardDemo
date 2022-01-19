//
//  MyCollectionViewController.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/11.
//

import UIKit

class MyCollectionViewController: UIViewController {
    
    // MARK: - 뷰 생성
    // 컬렉션 뷰 이용
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()
    
    // 페이지 컨트롤
    let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 3
        page.currentPage = 0
        page.pageIndicatorTintColor = UIColor(r: 193, g: 200, b: 214, alpha: 1)
        page.currentPageIndicatorTintColor = UIColor(r: 96, g: 127, b: 255, alpha: 1)
        page.addTarget(self, action: #selector(movePage), for: .valueChanged)
        return page
    }()
    
    // 나가기 버튼 레이아웃을 잡기위해 empty뷰 생성
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // 나가기 버튼
    let exitBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(UIColor(r: 255, g: 0, b: 255, alpha: 0.3)), for: .normal)
        button.tintColor = .black
        button.backgroundColor = UIColor(r: 255, g: 255, b: 255, alpha: 1)
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
        
        // 스크린 사이즈 대응
        if isScreenTraitRR(trait: traitCollection) {
            // RR
            configureRRCollectionVC()
        } else {
            configureCollectionVC()
        }
    }
    
    // MARK: - 가로모드 세로모드 대응
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.collectionView.reloadData()
            self.movePage()
        }
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .top, animated: false)
        }
    }
    
    // MARK: - 서브뷰 추가 및 레이아웃 설정
    func configureCollectionVC() {
        // 컬렉션 뷰
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(406)
        }
        
        // 페이지 컨트롤
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24 * view.frame.height / 760)
            make.centerX.equalToSuperview()
            make.height.equalTo(6)
        }
        
        // 더미 뷰
        view.addSubview(emptyView)
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaInsets.bottom)
        }
        
        // 나가기 버튼
        emptyView.addSubview(exitBtn)
        
        exitBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(52)
        }
    }
    
    
    // MARK: - RR 레이아웃 설정
    func configureRRCollectionVC() {
        // 컬렉션 뷰
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(466)
        }
    
        // 페이지 컨트롤
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(32 * view.frame.height / 760)
            make.centerX.equalToSuperview()
            make.height.equalTo(6)
        }
    
        // 더미 뷰
        view.addSubview(emptyView)
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaInsets.bottom)
        }
    
        // 나가기 버튼
        emptyView.addSubview(exitBtn)
        
        exitBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(52)
        }
    }
    
    // MARK: - objc 함수 설정
    // modal 나가기 버튼
    @objc func moveToMain() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 페이지 컨트롤을 눌렀을 때 페이지로 이동
    @objc func movePage() {
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

}


// MARK: - 컬렉션뷰 DataSource, Delegate
extension MyCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // 지정된 섹션에 표시할 항목의 개수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    // 컬렉션뷰의 지정된 위치에 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell

            // 데이터 받아와서 넣어줄 부분
            cell.profileImage.image = UIImage(named: "이상봉")
            cell.teamLabel.text = "더존비즈온 / 모바일Cell팀"
            cell.nameLabel.text = "이상봉"
            
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "qrcodeCell", for: indexPath) as! QRCodeCollectionViewCell
            
            cell.emailLabel.text = "bongbong9708@douzone.com"
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attendanceCell", for: indexPath) as! AttendanceCollectionViewCell
            
            // alert을 사용하기 위해 present 메서드를 사용하기 위해 속성 설정
            cell.viewController = self
            
            return cell
        }
    }
}


// MARK: - 컬렉션뷰 DelegateFlowLayout
extension MyCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // 지정된 셀의 크기를 반환하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isScreenTraitRR(trait: traitCollection) {
            return CGSize(width: 360, height: collectionView.frame.height)
        } else {
            return CGSize(width: 300, height: collectionView.frame.height)
        }
    }

    // 지정된 섹션의 행 사이 간격 최소 간격을 반환하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if isScreenTraitRR(trait: traitCollection) {
            return CGFloat(collectionView.frame.width - 360)
        } else {
            return CGFloat(collectionView.frame.width - 300)
        }
    }
    
    // 지정된 섹션의 여백을 반환하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if isScreenTraitRR(trait: traitCollection) {
            return UIEdgeInsets(top: 0, left: (collectionView.frame.width - 360) / 2, bottom: 0, right: (collectionView.frame.width - 360) / 2)
        } else {
            return UIEdgeInsets(top: 0, left: (collectionView.frame.width - 300) / 2, bottom: 0, right: (collectionView.frame.width - 300) / 2)
        }
    }
    
}


// MARK: - pageControll 설정
extension MyCollectionViewController: UIScrollViewDelegate {
    
    // 컬렉션뷰를 스크롤하면 페이지 컨트롤 반복적으로 호출
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width //
        
        let x = scrollView.contentOffset.x + (width/2)
        
        let newPage = Int(x/width)
        if pageControl.currentPage != newPage {
            pageControl.currentPage = newPage
        }
    }
}

