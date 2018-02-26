//
//  ZGAlertTipView.swift
//  AlertView
//
//  Created by Magic on 2018/2/26.
//  Copyright © 2018年 magic. All rights reserved.
//

import UIKit

enum AlertClickType:NSInteger {
    case AlertClickType_left  = 0
    case AlertClickType_right = 1
}
typealias AlertTipViewBlock = (_ type:AlertClickType)->()
fileprivate let kZGShowAlertMenuKey = 999

class ZGAlertTipView: UIView {

    @IBOutlet weak var tipMessage: UILabel!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    
    fileprivate var block:AlertTipViewBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(clickedNullArea(ges:)))
        self.addGestureRecognizer(tap)
    }
    
    @IBAction func clickedLeftBtn()
    {
        if block != nil {
            block!(.AlertClickType_left)
        }
        self.dissmissView()
    }
    @IBAction func clickedRightBtn()
    {
        if block != nil {
            block!(.AlertClickType_right)
        }
        self.dissmissView()
    }
    @objc func clickedNullArea(ges:UITapGestureRecognizer)
    {
        let point:CGPoint = ges.location(in: ges.view)
        if !contentView.frame.contains(point) {
            dissmissView()
        }
    }
    
}

extension ZGAlertTipView
{
    class func showAlertTipView(contentMessage message:String,leftBtnTitle leftTitle:String,rightBtnTitle rightTitle:String,alertBtnClickedBlock clickedBlock:@escaping(_ type:AlertClickType)->())->(ZGAlertTipView)
    {
        let showView:ZGAlertTipView = Bundle.main.loadNibNamed(String(describing: ZGAlertTipView.self), owner: nil, options: nil)?.first as! ZGAlertTipView
        UIApplication.shared.keyWindow?.endEditing(true)
        let window:UIWindow = UIApplication.shared.keyWindow!
        
        showView.frame = window.bounds
        showView.tag = kZGShowAlertMenuKey
        showView.leftBtn.setTitle(leftTitle, for: .normal)
        showView.rightBtn.setTitle(rightTitle, for: .normal)
        showView.tipMessage.text = message
        showView.block = clickedBlock
        removeLastAlertView(window: window)
        window.addSubview(showView)
        showView.showView()
        
        return showView
    }
    class fileprivate func removeLastAlertView(window:UIWindow)
    {
        for subView in window.subviews {
            if subView.tag == kZGShowAlertMenuKey
            {
                subView.removeFromSuperview();return
            }
        }
    }
    
    fileprivate func showView()
    {
        let frame:CGRect = contentView.frame
        var newFrame:CGRect = frame
        self.alpha = 0.1
        newFrame.origin.y = self.frame.size.height
        contentView.frame = newFrame
        weak var weakSelf = self
        UIView.animate(withDuration: 0.25) {
            weakSelf?.contentView.frame = frame
            weakSelf?.alpha = 1
        }
        
    }
    fileprivate func dissmissView()
    {
        var frame:CGRect = contentView.frame
        frame.origin.y += frame.size.height
        weak var weakSelf = self
        UIView.animate(withDuration: 0.25, animations: {
            weakSelf?.contentView.frame = frame
            weakSelf?.alpha = 0.1
        }) { (finished) in
            weakSelf?.removeFromSuperview()
        }
    }
}
