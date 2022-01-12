//
//  ProfileCollectionViewCell.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/12.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        configureBaseView()
        configureBaseSubView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
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
    
    // MARK: - Constraints
    
    func configureBaseView() {
        self.contentView.addSubview(baseView)
        
        baseView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.frame.height / 398 * 200)
        }
    }
    
    func configureBaseSubView() {
        baseView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(16 * baseView.frame.height / 200)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20 * baseView.frame.height / 200)
        }
        
    }
}
