//
//  Extensions.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/18.
//

import Foundation
import UIKit

extension Date {
    
    // 근무시간 관리에서 초기화에 필요한 부분
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
}

extension NSObject {
    /// 현재 화면 스크린이 R:R 인지 판단
    /// - Parameter trait: UITraitCollection (UIView, UIViewController 에서 전달받아야함)
    /// - Returns: (Bool) isTraitRR
    @objc func isScreenTraitRR(trait:UITraitCollection) -> Bool {
        var isTraitRR:Bool = false
        
        // # 위치값에 따른 화면 전환
        switch (trait.horizontalSizeClass, trait.verticalSizeClass) {
        case (.regular, .regular):
           isTraitRR = true
        default:
           isTraitRR = false
           break
        }
        
        
        return isTraitRR
    }
}

extension UIColor {
    //    convenience : 보조 이니셜라이져
    convenience init(r:Int, g:Int, b:Int, alpha:CGFloat) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
}
