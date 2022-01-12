//
//  QRCodeCollectionViewCell.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/11.
//

import UIKit
import SnapKit

class QRCodeCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
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
    
    let explainLabel: UILabel = {
        let label = UILabel()
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
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .white
        return img
    }()
    
    
    // MARK: - Constraints
    
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
    }
    
    func configureImageView() {
        baseView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
    }
    
    
    
    
    
}
