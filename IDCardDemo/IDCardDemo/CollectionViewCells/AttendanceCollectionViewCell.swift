//
//  AttendanceCollectionViewCell.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/11.
//

import UIKit

class AttendanceCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureContentView()

        configureBaseView()
        configureBaseSubView()
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
    }
}
