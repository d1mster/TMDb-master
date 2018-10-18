//
//  DMLoader.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/18/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class DMLoader: NSObject {
    var currentView: UIView!
    var mainView: UIView!
    var aboveView: UIView!
    
    init(view: UIView){
        super.init()
        
        self.currentView = view
        self.initFrame()
    }
    
    private func initFrame(){
        let viewWidth = self.currentView.bounds.size.width
        let viewHeight = self.currentView.bounds.size.height
        let indicatorSize: CGFloat = self.currentView.bounds.width/5
        
        self.mainView = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: UIScreen.main.bounds.size.height))
        
        mainView.backgroundColor = Helper.current.viewBackground
        
        let frame = CGRect(x: (viewWidth-indicatorSize)/2, y: (viewHeight-indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                            type: .ballRotateChase, color: Helper.current.tint)
        
        
        self.currentView.addSubview(mainView)
        self.mainView.addSubview(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
        
        self.mainView.isHidden = true
    }
    
    internal func stop(){
        self.currentView.isUserInteractionEnabled = true
        DispatchQueue.main.async{
            self.hide()
        }
        
    }
    private func hide(){
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.alpha = 0
        }) { _ in
            self.mainView.isHidden = true
        }
    }
    
    internal func start(){
        DispatchQueue.main.async{
            self.currentView.isUserInteractionEnabled = false
            self.mainView.alpha = 1
            self.mainView.isHidden = false
            
        }
    }
    
    
    
    
}
