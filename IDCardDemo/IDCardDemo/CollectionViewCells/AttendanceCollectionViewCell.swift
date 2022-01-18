//
//  AttendanceCollectionViewCell.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/11.
//

import UIKit
import Toast

class AttendanceCollectionViewCell: UICollectionViewCell {
    
    // 컬렉션뷰셀에는 present메서드가 없어 뷰컨트롤러 참조
    weak var viewController: UIViewController?
    
    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureContentView()

        configureBaseView()
        configureBaseSubView()
        timeRecordSubViews()
        
        configureContentSubView()
        
        daySetting()
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
        label.text = "나의 근무시간 관리"
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
    
    let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "금일"
        label.textColor = UIColor(displayP3Red: 32/255, green: 201/255, blue: 151/255, alpha: 1)
        label.backgroundColor = UIColor(displayP3Red: 32/255, green: 201/255, blue: 151/255, alpha: 0.1)
        label.layer.borderColor = CGColor(srgbRed: 32/255, green: 201/255, blue: 151/255, alpha: 1)
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 3
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        
        // 날짜 설정
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd(E)"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        let convertDate = dateFormatter.string(from: nowDate)
        
        label.text = "\(convertDate)"
        label.textColor = UIColor(displayP3Red: 139/255, green: 139/255, blue: 143/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)

        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        if UserDefaults.standard.string(forKey: "workingDetailTime") == nil {
            label.text = "00:00:00"
        } else {
            label.text = UserDefaults.standard.string(forKey: "workingDetailTime")
        }
        label.textColor = UIColor(displayP3Red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    
    let timeRecordView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        view.layer.shadowColor = CGColor(srgbRed: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
        view.layer.shadowRadius = 5 // 반경
        view.layer.shadowOpacity = 0.3 // alpha값
        view.layer.cornerRadius = 8
        return view
    }()
    
    let midlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 242/255, green: 245/255, blue: 248/255, alpha: 1)
        return view
    }()
    
    let workingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "출근시간"
        label.textColor = UIColor(displayP3Red: 139/255, green: 139/255, blue: 143/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let workTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "퇴근시간"
        label.textColor = UIColor(displayP3Red: 139/255, green: 139/255, blue: 143/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let workingLabel: UILabel = {
        let label = UILabel()
        if UserDefaults.standard.string(forKey: "workingTime") == nil {
            label.text = "미등록"
            label.textColor = UIColor(displayP3Red: 195/255, green: 197/255, blue: 201/255, alpha: 1)
        } else {
            label.text = UserDefaults.standard.string(forKey: "workingTime")
            label.textColor = UIColor(displayP3Red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
        }
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    let workLabel: UILabel = {
        let label = UILabel()
        if UserDefaults.standard.string(forKey: "workTime") == nil {
            label.text = "미등록"
            label.textColor = UIColor(displayP3Red: 195/255, green: 197/255, blue: 201/255, alpha: 1)
        } else {
            label.text = UserDefaults.standard.string(forKey: "workTime")
            label.textColor = UIColor(displayP3Red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
        }
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    let worktimeBtnView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 77/255, green: 124/255, blue: 254/255, alpha: 1)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    let workingTimeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("출근", for: .normal)
        button.setTitleColor(UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        // 출퇴근 버튼 Alert 생성
        button.addTarget(self, action: #selector(workingAlert), for: .touchUpInside)
        return button
    }()
    
    let workMidLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 242/255, green: 245/255, blue: 248/255, alpha: 1)
        return view
    }()
    
    let workTimeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("퇴근", for: .normal)
        button.setTitleColor(UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1) , for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        // 출퇴근 버튼 Alert 생성
        button.addTarget(self, action: #selector(workAlert), for: .touchUpInside)
        return button
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
            make.height.equalTo(contentView.frame.height / 398 * 200)
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
        
        // 금일라벨
        baseView.addSubview(todayLabel)
        
        todayLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(25.6)
            make.leading.equalToSuperview().offset(86)
            make.height.equalTo(16)
        }
        
        // 날짜라벨
        baseView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(23)
            make.leading.equalTo(todayLabel.snp.trailing).offset(7)
            make.trailing.equalToSuperview().offset(-85)
            make.height.equalTo(20)
        }
        
        // 시간 라벨
        baseView.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(1)
            make.centerX.equalToSuperview()
//            make.width.equalTo(142)
            make.height.equalTo(50)
        }
    }
        
    func timeRecordSubViews() {
        // 시간을 기록하는 뷰
        baseView.addSubview(timeRecordView)
        
        timeRecordView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(112)
        }
        
        // 출퇴근 시간 사이에 칸막이?
        timeRecordView.addSubview(midlineView)
        
        midlineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview().offset(134)
            make.trailing.equalToSuperview().offset(-133)
            make.bottom.equalToSuperview().offset(-28)
        }
        
        // 출근 시간
        timeRecordView.addSubview(workingTimeLabel)
        
        workingTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalToSuperview().offset(42)
            make.trailing.equalTo(midlineView.snp.leading).offset(-42)
        }
        
        // 퇴근 시간
        timeRecordView.addSubview(workTimeLabel)
        
        workTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalTo(midlineView.snp.trailing).offset(41)
            make.trailing.equalToSuperview().offset(-42)
            // 삭제예정
            make.bottom.equalToSuperview().offset(-65)
        }
        
        // 출근 시간 - 진짜시간
        timeRecordView.addSubview(workingLabel)
        
        workingLabel.snp.makeConstraints { make in
            make.top.equalTo(workingTimeLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(38)
            make.width.equalTo(80)
            make.bottom.equalToSuperview().offset(-28)
        }
        
        // 퇴근 시간 - 진짜시간
        timeRecordView.addSubview(workLabel)
        
        workLabel.snp.makeConstraints { make in
            make.top.equalTo(workTimeLabel.snp.bottom).offset(6)
            make.width.equalTo(80)
            make.trailing.equalToSuperview().offset(-38)
            make.bottom.equalToSuperview().offset(-28)
        }
    }
    
    func configureContentSubView() {
        
        // 출퇴근 버튼있는 뷰
        contentView.addSubview(worktimeBtnView)
        
        worktimeBtnView.snp.makeConstraints { make in
            make.top.equalTo(timeRecordView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-54)
        }
        
        // 출근 버튼
        worktimeBtnView.addSubview(workingTimeBtn)
        
        workingTimeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(54)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        // 출퇴근 버튼 사이 칸막이?
        worktimeBtnView.addSubview(workMidLineView)
        
        workMidLineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalTo(workingTimeBtn.snp.trailing).offset(54)
            make.width.equalTo(1)
            make.bottom.equalToSuperview().offset(-14)
        }
        
        // 퇴근 버튼
        worktimeBtnView.addSubview(workTimeBtn)
        
        workTimeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(workMidLineView.snp.trailing).offset(55)
            make.width.equalTo(26)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    
    // MARK: - 날짜 설정
    func daySetting() {
        let todayDate = Date().day
        UserDefaults.standard.set(todayDate, forKey: "todayDate")
        
        // 버튼을 눌렀을때 저장된 날짜와 현재의 날짜가 다르면 저장된 출퇴근 시간을 제거
        if UserDefaults.standard.string(forKey: "nowDate") != UserDefaults.standard.string(forKey: "todayDate") {
            UserDefaults.standard.removeObject(forKey: "workingDetailTime")
            UserDefaults.standard.removeObject(forKey: "workingTime")
            UserDefaults.standard.removeObject(forKey: "workDetailTime")
            UserDefaults.standard.removeObject(forKey: "workTime")
        }
    }

    
    // MARK: - objc 버튼 함수
    
    @objc func workingAlert() {
        let workingAlert = UIAlertController(title: "알림", message: "출근시간을 등록하시겠습니까?", preferredStyle: .alert)
        
        let cancelBtn = UIAlertAction(title: "취소", style: .cancel) { _ in
            // 취소 버튼을 눌렀을 때 값이 있으면 값을 표시 없으면 00:00:00 호출
            if UserDefaults.standard.string(forKey: "workingDetailTime") != nil {
                self.timeLabel.text = UserDefaults.standard.string(forKey: "workingDetailTime")
            } else {
                self.timeLabel.text = "00:00:00"
            }
        }
        
        let okeyBtn = UIAlertAction(title: "확인", style: .default) { _ in
            let date = Date()
            // 시간을 불러옴(시간:분:초)
            let workingDetialFormatter = DateFormatter()
            workingDetialFormatter.dateFormat = "HH:mm:ss"
            let workingDetailTime = workingDetialFormatter.string(from: date)
            
            // 현재시간 등록
            if UserDefaults.standard.string(forKey: "workingDetailTime") == nil {
                UserDefaults.standard.set(workingDetailTime, forKey: "workingDetailTime")
                self.timeLabel.text = UserDefaults.standard.string(forKey: "workingDetailTime")
            } else {
                self.timeLabel.text = UserDefaults.standard.string(forKey: "workingDetailTime")
            }
            
            // 시간을 불러옴(시간:분)
            let workingFormatter = DateFormatter()
            workingFormatter.dateFormat = "HH:mm"
            let workingTime = workingFormatter.string(from: date)
            
            // 출근시간등록
            if UserDefaults.standard.string(forKey: "workingTime") == nil {
                UserDefaults.standard.set(workingTime, forKey: "workingTime")
                self.workingLabel.text = UserDefaults.standard.string(forKey: "workingTime")
                self.workingLabel.textColor = UIColor(displayP3Red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
            }
            else {
                self.workingLabel.text = UserDefaults.standard.string(forKey: "workingTime")
                
                // 출근시간이 있으면 토스트 띄우기
                self.viewController?.view.makeToast("이미 출근시간이 등록되었습니다.", duration: 1, position: .bottom, title: nil, image: nil, style: .init(), completion: nil)
            }
        }
        
        workingAlert.addAction(cancelBtn)
        workingAlert.addAction(okeyBtn)
        
        viewController?.present(workingAlert, animated: true, completion: nil)
        
        // 버튼을 누르는 날짜 저장
        let nowDate = Date().day
        UserDefaults.standard.set(nowDate, forKey: "nowDate")
        
    }
    
    @objc func workAlert() {
        let workingAlert = UIAlertController(title: "알림", message: "퇴근시간을 등록하시겠습니까?", preferredStyle: .alert)
        
        let cancelBtn = UIAlertAction(title: "취소", style: .cancel) { _ in
            // 취소 버튼을 눌렀을 때 값이 있으면 값을 표시 없으면 00:00:00 호출
            if UserDefaults.standard.string(forKey: "workDetailTime") != nil {
                self.timeLabel.text = UserDefaults.standard.string(forKey: "workDetailTime")
            } else {
                self.timeLabel.text = "00:00:00"
            }
        }
        // 확인 버튼 누르면 시간이 등록되게
        let okeyBtn = UIAlertAction(title: "확인", style: .default) { _ in
            let date = Date()
            // 시간을 불러옴(시간:분:초)
            let workDetialFormatter = DateFormatter()
            workDetialFormatter.dateFormat = "HH:mm:ss"
            let workDetailTime = workDetialFormatter.string(from: date)

            // 퇴근 현재시간
            if UserDefaults.standard.string(forKey: "workingDetailTime") == nil {
                UserDefaults.standard.removeObject(forKey: "workDetailTime")
            } else {
                if UserDefaults.standard.string(forKey: "workDetailTime") == nil {
                    UserDefaults.standard.set(workDetailTime, forKey: "workDetailTime")
                    self.timeLabel.text = UserDefaults.standard.string(forKey: "workDetailTime")
                } else {
                    UserDefaults.standard.removeObject(forKey: "workDetailTime")
                    UserDefaults.standard.set(workDetailTime, forKey: "workDetailTime")
                    self.timeLabel.text = UserDefaults.standard.string(forKey: "workDetailTime")
                }
            }
            
            // 시간을 불러옴(시간:분)
            let workFormatter = DateFormatter()
            workFormatter.dateFormat = "HH:mm"
            let workTime = workFormatter.string(from: date)

            // 퇴근시간 등록
            if UserDefaults.standard.string(forKey: "workingTime") == nil {
                UserDefaults.standard.removeObject(forKey: "workTime")
            } else {
                if UserDefaults.standard.string(forKey: "workTime") == nil {
                    UserDefaults.standard.set(workTime, forKey: "workTime")
                    self.workLabel.text = UserDefaults.standard.string(forKey: "workTime")
                    self.workLabel.textColor = UIColor(displayP3Red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
                } else {
                    UserDefaults.standard.removeObject(forKey: "workTime")
                    UserDefaults.standard.set(workTime, forKey: "workTime")
                    self.workLabel.text = UserDefaults.standard.string(forKey: "workTime")
                }
            }
        }
        
        workingAlert.addAction(cancelBtn)
        workingAlert.addAction(okeyBtn)
        
        viewController?.present(workingAlert, animated: true, completion: nil)
    }
    
}
