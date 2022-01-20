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
        
        // 스크린 사이즈 대응
        if isScreenTraitRR(trait: traitCollection) {
            configureRRQRCodeView()
            configureRRHiddenQRCodeView()
        } else {
            configureQRCodeView()
            configureHiddenQRCodeView()
        }
        
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View 생성
    
    let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 237, g: 241, b: 247, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "출퇴근 체크 QR"
        label.textColor = UIColor(r: 0, g: 0, b: 0, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 60, g: 60, b: 67, alpha:  0.06)
        return view
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.text = "근태기에 QR코드를 인식해주세요."
        label.textColor = UIColor(r: 99, g: 99, b: 105, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let imageBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255, alpha: 1)
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
        view.layer.shadowRadius = 5 // 반경
        view.layer.shadowOpacity = 0.3 // alpha값
        return view
    }()
    
    // MARK: - QR코드
    let QRImage: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    let clearView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let clockImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icClockBlSSele")
        return img
    }()
    
    let remainTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "남은시간"
        label.textColor = UIColor(r: 139, g: 139, b: 143, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let remainTime: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 77, g: 124, b: 254, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let progressView: UIProgressView = {
        let bar = UIProgressView()
        bar.progressViewStyle = .default
        bar.progressTintColor = UIColor(r: 77, g: 124, b: 254, alpha: 1)
        bar.trackTintColor = UIColor(r: 193, g: 200, b: 214, alpha: 1)
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
        button.backgroundColor = UIColor(r: 77, g: 124, b: 254, alpha: 1)
        button.isHidden = true
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "icReflashWrMNone"), for: .normal)
        button.addTarget(self, action: #selector(timerRestart), for: .touchUpInside)
        return button
    }()
    
    let hiddenText: UILabel = {
        let label = UILabel()
        label.text = "재발급"
        label.textColor = UIColor(r: 0, g: 0, b: 0, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    let hiddenClearView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let hiddenClockImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icClockBlSSele")
        img.isHidden = true
        return img
    }()
    
    let hiddenTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "유효시간이 만료되었습니다."
        label.textColor = UIColor(r: 139, g: 139, b: 143, alpha: 1)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 13)
        label.isHidden = true
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    // MARK: - Constraints
    func configureContentView() {
        backgroundColor = UIColor(r: 255, g: 255, b: 255, alpha: 1)
        clipsToBounds = true
        layer.cornerRadius = 8
    }
    
    func configureQRCodeView() {
        addSubview(baseView)
        
        baseView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // 타이틀 라벨
        baseView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
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
            make.centerX.equalToSuperview()
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
        
        // 알람 + 남은시간 + 숫자
        contentView.addSubview(clearView)
        
        clearView.snp.makeConstraints { make in
            make.top.equalTo(imageBaseView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(19)
            make.width.equalTo(100)
        }
        
        // 알람 이미지
        clearView.addSubview(clockImage)
        
        clockImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(18)
        }
        
        // 남은 시간
        clearView.addSubview(remainTimeLabel)
        
        remainTimeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(clockImage.snp.trailing).offset(2)
            make.width.equalTo(48)
        }
        
        // 남은시간 - 숫자
        clearView.addSubview(remainTime)
        
        remainTime.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(remainTimeLabel.snp.trailing).offset(4)
            make.width.equalTo(28)
        }
        
        // 프로그레스뷰
        contentView.addSubview(progressView)
        
        progressView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(204)
            make.height.equalTo(6)
            make.bottom.equalToSuperview().offset(-70)
        }
    }
    
    func configureHiddenQRCodeView() {
        // 숨겨진 뷰
        QRImage.addSubview(hiddenQRView)
        
        hiddenQRView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 숨겨진 재발급 버튼
        contentView.addSubview(hiddenBtn)
        
        hiddenBtn.snp.makeConstraints { make in
            make.top.equalTo(QRImage.snp.top).offset(32)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        // 숨겨진 재발급 텍스트
        hiddenQRView.addSubview(hiddenText)
        
        hiddenText.snp.makeConstraints { make in
            make.top.equalTo(hiddenBtn.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
        }
        
        // 숨겨진 시계 + 숨겨진 유효만료 라벨
        contentView.addSubview(hiddenClearView)
        
        hiddenClearView.snp.makeConstraints { make in
            make.top.equalTo(imageBaseView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(168)
            make.height.equalTo(19)
        }
        
        // 숨겨진 시계
        hiddenClearView.addSubview(hiddenClockImage)
        
        hiddenClockImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.leading.bottom.equalToSuperview()
            make.width.height.equalTo(18)
        }
        
        // 숨겨진 유효시간 만료라벨
        hiddenClearView.addSubview(hiddenTimeLabel)
        
        hiddenTimeLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(hiddenClockImage.snp.trailing).offset(2)
        }
    }
    
    
    // MARK: - RR Constraints
    func configureRRQRCodeView() {
        // 베이스 뷰
        contentView.addSubview(baseView)
        
        baseView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(220)
        }
        
        // 타이틀 라벨
        baseView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
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
            make.top.equalTo(lineView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        // QR베이스뷰
        baseView.addSubview(imageBaseView)
        
        imageBaseView.snp.makeConstraints { make in
            make.top.equalTo(explainLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(148)
        }
        
        // QR이미지
        imageBaseView.addSubview(QRImage)
        
        QRImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        // 클리어 뷰
        contentView.addSubview(clearView)
        
        clearView.snp.makeConstraints { make in
            make.top.equalTo(imageBaseView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(19)
            make.width.equalTo(100)
        }
        
        // 알람 이미지
        clearView.addSubview(clockImage)
        
        clockImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(18)
        }
        
        // 남은 시간
        clearView.addSubview(remainTimeLabel)
        
        remainTimeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(clockImage.snp.trailing).offset(2)
            make.width.equalTo(48)
        }
        
        // 남은시간 - 숫자
        clearView.addSubview(remainTime)
        
        remainTime.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(remainTimeLabel.snp.trailing).offset(4)
            make.width.equalTo(28)
        }
        
        // 프로그레스뷰
        contentView.addSubview(progressView)
        
        progressView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(264)
            make.height.equalTo(6)
            make.bottom.equalToSuperview().offset(-85)
        }
    }
    
    func configureRRHiddenQRCodeView() {
        // 숨겨진 뷰
        QRImage.addSubview(hiddenQRView)
        
        hiddenQRView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 숨겨진 재발급 버튼
        contentView.addSubview(hiddenBtn)
        
        hiddenBtn.snp.makeConstraints { make in
            make.top.equalTo(QRImage.snp.top).offset(32)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        // 숨겨진 재발급 텍스트
        hiddenQRView.addSubview(hiddenText)
        
        hiddenText.snp.makeConstraints { make in
            make.top.equalTo(hiddenBtn.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
        }
        // 숨겨진 시계 + 숨겨진 유효만료 라벨
        contentView.addSubview(hiddenClearView)
        
        hiddenClearView.snp.makeConstraints { make in
            make.top.equalTo(imageBaseView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(168)
            make.height.equalTo(19)
        }
        
        // 숨겨진 시계
        hiddenClearView.addSubview(hiddenClockImage)
        
        hiddenClockImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.leading.bottom.equalToSuperview()
            make.width.height.equalTo(18)
        }
        
        // 숨겨진 유효시간 만료라벨
        hiddenClearView.addSubview(hiddenTimeLabel)
        
        hiddenTimeLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(hiddenClockImage.snp.trailing).offset(2)
        }
    }
    
    // MARK: - 타이머 세팅
    var timer: Timer?
    var timerNum: Double = 0
    var totalTimerNum: Double = 0
    
    func startTimer() {
        // 기존에 타이머 동작중이면 중지 처리
        if timer != nil && timer!.isValid {
            timer!.invalidate()
        }
        
        // 타이머 사용값 초기화
        timerNum = 15.0
        totalTimerNum = timerNum * 3
        
        // 1초 간격 타이머 시작
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        
        QRCode().generateQRCode(img: QRImage)
    }
    
    @objc func timerCallback() {
        // 15초 ~ 1초 까지 timeBtn의 타이틀 변경
        self.remainTime.text = "\(Int(timerNum))초"
        progressView.setProgress(Float(0.067*(15.0-Double(timerNum))), animated: true)
        
        // timerNum이 0이면(15초 경과) 타이머 종료
        if (timerNum <= 0) {
            // 다시 타이머를 15초로 + progressView 돌아가는 시간 1초
            // totalTimerNum이 15*3+2 = 47 이여야함 그래서 16초 설정 -> 15초 설정시 무한 루프..
            timerNum = 15.0
            
            // 15초 마다 발급
            QRCode().generateQRCode(img: QRImage)
            
            if totalTimerNum <= 0 {
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
        timerNum -= 0.01
        totalTimerNum -= 0.01
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
