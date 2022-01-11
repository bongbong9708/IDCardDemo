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
        
//        configureImageView()
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
            make.height.equalTo(contentView.frame.height / 398 * 200)
        }
        
        baseView.addSubview(titleLabel)
//        baseView.addSubview(lineView)
//        baseView.addSubview(explainLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(16 * baseView.frame.height / 200)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20 * baseView.frame.height / 200)
        }
    }
    
    func configureBaseSubView() {
        
    }
    
    func configureImageView() {
        baseView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
    }
    
    
    
    
    
}
