//
//  ProfileCollectionViewCell.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/12.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // contentView
        configureContentView()
        
        configureBaseView()
        configureBaseSubView()
        configureContentSubView()
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
        label.text = "전자사원증"
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
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    let teamLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 139/255, green: 139/255, blue: 143/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let shortLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 77/255, green: 124/255, blue: 254/255, alpha: 1)
        return view
    }()
    
    let proveLabel: UILabel = {
        let label = UILabel()
        label.text = "상기인은 당사 임직원임을 증명합니다."
        label.textColor = UIColor(displayP3Red: 139/255, green: 139/255, blue: 143/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    
    // MARK: - Constraints
    
    func configureContentView() {
        backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        clipsToBounds = true
        layer.cornerRadius = 8
    }
    
    func configureBaseView() {
        self.contentView.addSubview(baseView)
        
        baseView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    func configureBaseSubView() {
        // 타이틀 - 전자사원증
        baseView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        // 라인
        baseView.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        // 프로필 사진
        baseView.addSubview(profileImage)
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(34)
            make.centerX.equalToSuperview()
            make.width.equalTo(118)
            make.height.equalTo(138)
        }
    }
    
    func configureContentSubView() {
        // 팀라벨
        contentView.addSubview(teamLabel)
        
        teamLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        // 이름라벨
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(teamLabel.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(33)
        }
        
        // 짧은 라인
        contentView.addSubview(shortLineView)
        
        shortLineView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(135)
            make.trailing.equalToSuperview().offset(-133)
            make.height.equalTo(2)
        }
        
        // 임직원 증명 설명 라벨
        contentView.addSubview(proveLabel)
        
        proveLabel.snp.makeConstraints { make in
            make.top.equalTo(shortLineView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(19)
        }
    }
}
