//
//  ViewController.swift
//  Demo
//
//  Created by Mac on 4/5/18.
//  Copyright © 2018 Green Moby. All rights reserved.
//

import UIKit
import iOSLogger

class ViewController: UIViewController {
    
    var allLogs : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var vButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var iButton: UIButton!
    @IBOutlet weak var wButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var readLogsButton: UIButton!
    @IBOutlet weak var sendLogsButton: UIButton!
    
    @IBOutlet weak var enterText: UITextField!
    @IBOutlet weak var consoleText: UILabel!
    
    @IBAction func vActionButton(_ sender: Any) {
        IOSLogger.v(textLog: enterText.text!)
        allLogs = "\(allLogs)Verbose: \(enterText.text!)\n"
        consoleText.text = allLogs
    }
    
    @IBAction func dActionButton(_ sender: Any) {
        IOSLogger.d(textLog: enterText.text!)
        allLogs = "\(allLogs)Debug: \(enterText.text!)\n"
        consoleText.text = allLogs
    }
    
    @IBAction func iActionButton(_ sender: Any) {
        IOSLogger.i(textLog: enterText.text!)
        allLogs = "\(allLogs)Info: \(enterText.text!)\n"
        consoleText.text = allLogs
    }
    
    @IBAction func wActionButton(_ sender: Any) {
        IOSLogger.w(textLog: enterText.text!)
        allLogs = "\(allLogs)Warn: \(enterText.text!)\n"
        consoleText.text = allLogs
    }
    
    @IBAction func eActionButton(_ sender: Any) {
        IOSLogger.e(textLog: enterText.text!)
        allLogs = "\(allLogs)Error: \(enterText.text!)\n"
        consoleText.text = allLogs
    }
    
    @IBAction func readLogsActionButton(_ sender: Any) {
        IOSLogger.readLogs()
        consoleText.text = allLogs + allLogs
    }
    
    @IBAction func sendLogsActionButton(_ sender: Any) {
        IOSLogger.sendLogs(viewController: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        enterText.resignFirstResponder()
    }
}
