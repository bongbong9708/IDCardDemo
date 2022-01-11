//
//  AttendanceCollectionViewCell.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/11.
//

import UIKit

class AttendanceCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "상봉.png")
        img.backgroundColor = .white
        img.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return img
    }()
}
