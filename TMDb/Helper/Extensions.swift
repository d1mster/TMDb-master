//
//  Extensions.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/17/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import UIKit

extension UIView{
    
    @IBInspectable var cornerRadius: CGFloat{
        get {
            return 0.0
        }
        set(cornerRadius) {
            self.layer.cornerRadius = cornerRadius
        }
    }
}

extension String {
    
    func convertToURL() -> String{
        
        let stringUrl = Helper.current.imageStaticUrl + self
        let url = stringUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return url
    }
    
    func getDatefromTimeStamp (strdateFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
        
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = strdateFormat
        let datestr = dateFormatter.string(from: date!)
        return datestr
        
    }
}

extension UIViewController {
    class func storyboardInstance(storyboardId: String, restorationId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: restorationId)
    }
}
