//
//  ViewController.swift
//  SwiftSMSAnalyzer
//
//  Created by Mobile on 23/07/18.
//  Copyright © 2018 MobileFirst Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtMessageInput: UITextView!
    @IBOutlet weak var txtMessageInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let output = SwiftSMSAnalyzer.analyze(text: textView.text!)
        self.txtMessageInfo.text =  "Encoding: \(output.encoding)" +
                                    "\nLength \(output.length)" +
                                    "\nNumber Of Messages: \(output.messages)" +
                                    "\nCharacters Per Message: \(output.perMessage)" +
                                    "\nRemaining Characters: \(output.remaining)"
    }
    
}
