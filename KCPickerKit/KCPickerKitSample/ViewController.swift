//
//  ViewController.swift
//  KCPickerKitSample
//
//  Created by Kan Chen on 10/31/16.
//  Copyright © 2016 kcPickerKit. All rights reserved.
//

import UIKit
import KCPickerKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func datePickerButtonTapped(_ sender: UIButton) {
        if sender.isFirstResponder {
            sender.resignFirstResponder()
        } else {
            sender.becomeFirstResponder()
        }
    }
}

