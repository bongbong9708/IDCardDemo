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
        page.pageIndicatorTintColor = UIColor(displayP3Red: 193/255, green: 200/255, blue: 214/255, alpha: 1)
        page.currentPageIndicatorTintColor = UIColor(displayP3Red: 96/255, green: 127/255, blue: 255/255, alpha: 1)
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
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.black), for: .normal)
        button.tintColor = .black
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
        
    
    // MARK: - viewWillAppear
    // QR코드 사진 데이터를 넣어서 무리없이 2번째 화면으로 나타나는데 QR코드를 생성하게되면 생성 시간 때문인지 딜레이되는 시간이 있어서 1번째 화면 이후 이동을 하게 됩니다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .top, animated: false)
        }
    }
    
    // MARK: - 서브뷰 추가 및 레이아웃 설정
    func configureCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(406)
        }
    }
    
    func configurePageControll() {
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24 * view.frame.height / 760)
            make.centerX.equalToSuperview()
            make.height.equalTo(6)
        }
    }
    
    func configureEmptyView() {
        view.addSubview(emptyView)
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaInsets.bottom)
        }
    }
    
    func configureExitBtn() {
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(collectionView.frame.width - 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: (collectionView.frame.width - 300) / 2, bottom: 0, right: (collectionView.frame.width - 300) / 2)
    }
    
}


// MARK: - pageControll 설정
extension MyCollectionViewController: UIScrollViewDelegate {
    
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

