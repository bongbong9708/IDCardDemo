//
//  QRCodeCollectionViewCell.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/11.
//

import UIKit

class QRCodeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureContentView()
        
        configureBaseView()
        configureBaseSubView()
        configureContentSubView()
        configureHiddenView()
        
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View 생성
    
    let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 237/255, green: 241/255, blue: 247/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "출퇴근 체크 QR"
        label.textColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 60/255, green: 60/255, blue: 67/255, alpha: 0.06)
        return view
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.text = "근태기에 QR코드를 인식해주세요."
        label.textColor = UIColor(displayP3Red: 99/255, green: 99/255, blue: 105/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let imageBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
        view.layer.shadowRadius = 5 // 반경
        view.layer.shadowOpacity = 0.3 // alpha값
        return view
    }()
    
    // MARK: - QR코드 임시 (수정예정) 시뮬레이터는 안뜨고 실기기에서는 QR이 생성
    // 우선 이미지로 해놓고 다른 작업 후 진행예정
    let QRImage: UIImageView = {
        let img = UIImageView()
        
//        let data = "https://www.naver.com".data(using: String.Encoding.ascii)
//        
//        let filter = CIFilter(name: "CIQRCodeGenerator")
//        filter?.setValue(data, forKey: "inputMessage")
//        let transform = CGAffineTransform(scaleX: 5, y: 5)
//        
//        if let output = filter?.outputImage?.transformed(by: transform) {
//            img.image = UIImage(ciImage: output)
//        }
        
        return img
    }()
    
    let clockImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icClockBlSSele")
        return img
    }()
    
    let remainTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "남은시간"
        label.textColor = UIColor(displayP3Red: 139/255, green: 139/255, blue: 143/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let remainTime: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 77/255, green: 124/255, blue: 254/255, alpha: 1)
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let progressView: UIProgressView = {
        let bar = UIProgressView()
        bar.progressViewStyle = .default
        bar.progressTintColor = UIColor(displayP3Red: 77/255, green: 124/255, blue: 254/255, alpha: 1)
        bar.trackTintColor = UIColor(displayP3Red: 193/255, green: 200/255, blue: 214/255, alpha: 1)
        bar.progress = 0.0
        return bar
    }()
    
    
    // MARK: - 숨겨진 view들
    let hiddenQRView: UIView = {
        let view = UIView()
        view.backgroundColor = .white .withAlphaComponent(0.9)
        view.isHidden = true
        return view
    }()
    
    let hiddenBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.isHidden = true
        button.addTarget(self, action: #selector(timerRestart), for: .touchUpInside)
        return button
    }()
    
    let hiddenText: UILabel = {
        let label = UILabel()
        label.text = "재발급"
        label.textColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    let hiddenClockImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "hiddenIcClockBlSSele")
        img.isHidden = true
        return img
    }()
    
    let hiddenTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "유효시간이 만료되었습니다."
        label.textColor = UIColor(displayP3Red: 139/255, green: 139/255, blue: 143/255, alpha: 1)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.isHidden = true
        return label
    }()
    
    
    // MARK: - Constraints
    
    func configureContentView() {
        backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        clipsToBounds = true
        layer.cornerRadius = 8
    }
    
    func configureBaseView() {
        addSubview(baseView)
        
        baseView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    func configureBaseSubView() {
        // 타이틀 라벨
        baseView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        // 라인뷰
        baseView.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        // 근태기 큐알 인식
        baseView.addSubview(explainLabel)
        
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(34)
            make.leading.equalToSuperview().offset(53)
            make.trailing.equalToSuperview().offset(-53)
            make.height.equalTo(20)
        }
        
        // QR베이스뷰
        baseView.addSubview(imageBaseView)
        
        imageBaseView.snp.makeConstraints { make in
            make.top.equalTo(explainLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(148)
        }
        
        // QR이미지
        imageBaseView.addSubview(QRImage)
        
        QRImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    func configureContentSubView() {
        
        // 알람 이미지
        contentView.addSubview(clockImage)
        
        clockImage.snp.makeConstraints { make in
            make.top.equalTo(imageBaseView.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(104)
            make.width.height.equalTo(18)
        }
        
        // 남은 시간
        contentView.addSubview(remainTimeLabel)
        
        remainTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(imageBaseView.snp.bottom).offset(25)
            make.leading.equalTo(clockImage.snp.trailing).offset(2)
            make.width.equalTo(48)
            make.height.equalTo(19)
        }
        
        // 남은시간 - 숫자
        contentView.addSubview(remainTime)
        
        remainTime.snp.makeConstraints { make in
            make.top.equalTo(imageBaseView.snp.bottom).offset(25)
            make.leading.equalTo(remainTimeLabel.snp.trailing).offset(4)
            make.width.equalTo(30)
            make.height.equalTo(19)
        }
        
        // 프로그레스뷰
        contentView.addSubview(progressView)
        
        // 임시 지정
        progressView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(204)
            make.height.equalTo(6)
            make.bottom.equalToSuperview().offset(-70)
        }
    }
    
    func configureHiddenView() {
        // 숨겨진 뷰
        QRImage.addSubview(hiddenQRView)
        
        hiddenQRView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 숨겨진 재발급 버튼
        hiddenQRView.addSubview(hiddenBtn)
        
        hiddenBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.equalToSuperview().offset(46)
            make.trailing.equalToSuperview().offset(-46)
        }
        
        // 숨겨진 재발급 텍스트
        hiddenQRView.addSubview(hiddenText)
        
        hiddenText.snp.makeConstraints { make in
            make.top.equalTo(hiddenBtn.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(47)
            make.trailing.equalToSuperview().offset(-47)
            make.bottom.equalToSuperview().offset(-32)
        }
        
        // 숨겨진 시계
        contentView.addSubview(hiddenClockImage)
        
        hiddenClockImage.snp.makeConstraints { make in
            make.top.equalTo(imageBaseView.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(70)
            make.width.height.equalTo(18)
        }
        
        // 숨겨진 유효시간 만료라벨
        contentView.addSubview(hiddenTimeLabel)
        
        hiddenTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(imageBaseView.snp.bottom).offset(25)
            make.leading.equalTo(hiddenClockImage.snp.trailing).offset(2)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(19)
        }
    }
    
    // MARK: - 타이머 세팅
    var timer: Timer?
    var timerNum: Int = 0
    var totalTimerNum: Int = 0
    
    func startTimer() {
        // 기존에 타이머 동작중이면 중지 처리
        if timer != nil && timer!.isValid {
            timer!.invalidate()
        }
        
        // 타이머 사용값 초기화
        timerNum = 2
        totalTimerNum = timerNum * 3
        
        // 1초 간격 타이머 시작
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    @objc func timerCallback() {
        // 15초 ~ 1초 까지 timeBtn의 타이틀 변경
        self.remainTime.text = "\(timerNum)초"
        progressView.setProgress(Float(timerNum), animated: true)
        
        
        
        // timerNum이 0이면(15초 경과) 타이머 종료
        if (timerNum == 0) {
            timerNum = 2

            if totalTimerNum == 0 {
                timer?.invalidate()
                
                clockImage.isHidden = true
                remainTimeLabel.isHidden = true
                remainTime.isHidden = true
                
                hiddenQRView.isHidden = false
                hiddenBtn.isHidden = false
                hiddenText.isHidden = false
                hiddenTimeLabel.isHidden = false
                hiddenClockImage.isHidden = false
            }
            
        }
        
        // 1초씩 감소시키기
        timerNum -= 1
        totalTimerNum -= 1
    }
    
    @objc func timerRestart() {
        clockImage.isHidden = false
        remainTimeLabel.isHidden = false
        remainTime.isHidden = false
        
        hiddenQRView.isHidden = true
        hiddenBtn.isHidden = true
        hiddenText.isHidden = true
        hiddenTimeLabel.isHidden = true
        hiddenClockImage.isHidden = true
        
        startTimer()
    }
    
}
