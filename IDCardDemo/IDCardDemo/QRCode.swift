//
//  QRCode.swift
//  IDCardDemo
//
//  Created by 이상봉 on 2022/01/17.
//

import UIKit
import CoreImage.CIFilterBuiltins

class QRCode {
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    // QR코드 생성
    func generateQRCode(img: UIImageView) {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let convertDate = dateFormatter.string(from: nowDate)
        
        let yearFormatter = DateFormatter()
        let monthFormatter = DateFormatter()
        let dayFormatter = DateFormatter()
        let hourFormatter = DateFormatter()
        let minuteFormatter = DateFormatter()
        let secondFormatter = DateFormatter()
        
        yearFormatter.dateFormat = "yyyy"
        monthFormatter.dateFormat = "mm"
        dayFormatter.dateFormat = "dd"
        hourFormatter.dateFormat = "hh"
        minuteFormatter.dateFormat = "mm"
        secondFormatter.dateFormat = "ss"
        
        let convertYear = Int(yearFormatter.string(from: nowDate)) ?? 0
        let convertMonth = Int(monthFormatter.string(from: nowDate)) ?? 0
        let convertDay = Int(dayFormatter.string(from: nowDate)) ?? 0
        let convertHour = Int(hourFormatter.string(from: nowDate)) ?? 0
        let convertMinute = Int(minuteFormatter.string(from: nowDate)) ?? 0
        let convertSecond = Int(secondFormatter.string(from: nowDate)) ?? 0
        
        let timeCheckSum = "\((convertYear + convertMonth*3 + convertDay*5 + convertHour*7 + convertMinute*11 + convertSecond)%13)"
        
        let personalDic = [
            "timeStamp": convertDate,
            "timeCheckSum": timeCheckSum
        ] as [String : Any]
        
        
        // QR데이터
        let base64Data = getMakeQRValue("bongbong9708@douzone.com", personalDic).data(using: .utf8)
        
        // QR코드로 변환
//        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter.setValue(base64Data, forKey: "inputMessage")

        let transform = CGAffineTransform(scaleX: 5, y: 5)

//        if let output = filter.outputImage?.transformed(by: transform) {
//            img.image = UIImage(ciImage: output)
//        }
        
        if let qrCodeImage = filter.outputImage?.transformed(by: transform) {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                img.image = UIImage(cgImage: qrCodeCGImage)
            }
        }
    }
    
    // 딕셔너리를 json 스트링 으로 변환
    func convertDictionaryToJsonString(dict: Dictionary<String, Any>) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions())
        if let jsonString = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue){
                return "\(jsonString)"
            }
            return ""
        }
    
    // QR값을 만드는 작업
    func getMakeQRValue(_ mail: String, _ personalDic: Dictionary<String,Any>) -> String {
        var makeString = ""

        makeString += "ec://"
        makeString += mail + "/"
        makeString += convertDictionaryToJsonString(dict: personalDic).data(using: .utf8)!.base64EncodedString()

        return makeString
    }
    
}

