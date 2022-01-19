//
//  ProfileCollectionViewCell.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/12.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // contentView
        configureContentView()
            
        // 스크린 사이즈 대응
        if isScreenTraitRR(trait: traitCollection) {
            configureRRBaseView()
            configureRRBaseSubView()
            configureRRContentSubView()
        } else {
            configureBaseView()
            configureBaseSubView()
            configureContentSubView()
        }
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
        label.text = "전자사원증"
        label.textColor = UIColor(r: 0, g: 0, b: 0, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 60, g: 60, b: 67, alpha: 0.06)
        return view
    }()
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    let teamLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 139, g: 139, b: 143, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 17, g: 17, b: 17, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let shortLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 77, g: 124, b: 254, alpha: 1)
        return view
    }()
    
    let proveLabel: UILabel = {
        let label = UILabel()
        label.text = "상기인은 당사 임직원임을 증명합니다."
        label.textColor = UIColor(r: 139, g: 139, b: 143, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    
    // MARK: - Constraints
    
    func configureContentView() {
        backgroundColor = UIColor(r: 255, g: 255, b: 255, alpha: 1)
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
            make.centerX.equalToSuperview().offset(-2)
            make.height.equalTo(20)
        }
        
        // 이름라벨
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(teamLabel.snp.bottom)
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
    
    
    // MARK: - RR Constraints
    
    func configureRRBaseView() {
        self.contentView.addSubview(baseView)
        
        baseView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(220)
        }
    }
    
    func configureRRBaseSubView() {
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
            make.top.equalTo(lineView.snp.bottom).offset(54)
            make.centerX.equalToSuperview()
            make.width.equalTo(118)
            make.height.equalTo(138)
        }
    }
    
    func configureRRContentSubView() {
        // 팀라벨
        contentView.addSubview(teamLabel)
        
        teamLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(24)
            make.centerX.equalToSuperview().offset(-2)
            make.height.equalTo(20)
        }
        
        // 이름라벨
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(teamLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(33)
        }
        
        // 짧은 라인
        contentView.addSubview(shortLineView)
        
        shortLineView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview().offset(-2)
            make.width.equalTo(32)
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
