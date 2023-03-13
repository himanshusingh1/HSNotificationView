//
//  ViewController.swift
//  HSNotificationView
//
//  Created by himanshusingh@hotmail.co.uk on 03/11/2023.
//  Copyright (c) 2023 himanshusingh@hotmail.co.uk. All rights reserved.
//

import UIKit
import HSNotificationView
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .red
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for i in 0 ... 100 {
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                HSNotificationView.show(font: .systemFont(ofSize: 14, weight: .bold), text: "\(i) hello! ",icon: UIImage(named: "icon"),timeout: .infinity, shouldCleanOldNotifications: true)
            }
        }
    }
}


