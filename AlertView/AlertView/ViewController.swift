//
//  ViewController.swift
//  AlertView
//
//  Created by Magic on 2018/2/26.
//  Copyright © 2018年 magic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func showView(_ sender: Any)
    {
        ZGAlertTipView.showAlertTipView(contentMessage: "您还没有支付密码,请先设置支付密码", leftBtnTitle: "取消", rightBtnTitle: "去设置") { [weak self](type) in
            ZGPrint(">>>:\(type)")
        }
    }
}

