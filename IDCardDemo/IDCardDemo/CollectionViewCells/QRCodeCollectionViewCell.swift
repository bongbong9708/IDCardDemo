//
//  QRCodeCollectionViewCell.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/11.
//

import UIKit

class QRCodeCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurebackgroundView()
        configureForegroundView()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let foregroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .white
        return img
    }()
    
    func configurebackgroundView() {
        addSubview(backView)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureForegroundView() {
        backView.addSubview(foregroundView)
        
        foregroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(backView.frame.height / 398 * 200)
        }
    }
    
    func configureImageView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
    }
    
    
    
    
    
}
