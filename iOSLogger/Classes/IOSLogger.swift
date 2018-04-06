
//
//  iOSLogger.swift
//  iOSTestTasck
//
//  Created by Kravchenko Pavel on 3/30/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

import Zip

public class IOSLogger : NSObject{
    
    public static let instance = IOSLogger()
    
    public static var appName: String = ""
    public static var authorEmail: String = ""
    public static var logFileURL: URL?
    public static let fileManager = FileManager.default
    public static var fileHandle: FileHandle?
    
    override init() {
        super.init()
        IOSLogger.myInit(appName: "app name", authorEmail: "author email")
    }
    
    public static func myInit(appName : String, authorEmail : String){
        IOSLogger.appName = appName
        IOSLogger.authorEmail = authorEmail
        
        let fileName = "\(IOSLogger.appName)";
        let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        if let url = dir?.appendingPathComponent(fileName).appendingPathExtension("txt") {
            IOSLogger.logFileURL = url
            print("iOSLogger: Logger is active")
        } else {
            print("iOSLogger: Error! Logger is not active")
        }
    }
    
    public static func log (with tag : String, textLog : String){
        IOSLogger.saveToFile(stringLog: "\(tag): \(textLog)")
    }
    
    public static func v (textLog : String){
        IOSLogger.saveToFile(stringLog: "Verbose: \(textLog)")
    }
    
    public static func d (textLog : String){
        saveToFile(stringLog: "Debug: \(textLog)")
    }
    
    public static func i (textLog : String){
        saveToFile(stringLog: "Info: \(textLog)")
    }
    
    public static func w (textLog : String){
        saveToFile(stringLog: "Warn: \(textLog)")
    }
    
    public static func e (textLog : String){
        saveToFile(stringLog: "Error: \(textLog)")
    }
    
    public static func saveToFile(stringLog : String) {
        print(stringLog)
        if let url = IOSLogger.logFileURL {
            do {
                if fileManager.fileExists(atPath: url.path) == false {
                    let line = stringLog + "\n"
                    try line.write(to: url, atomically: true, encoding: .utf8)
                    
                    #if os(iOS) || os(watchOS)
                        if #available(iOS 10.0, watchOS 3.0, *) {
                            var attributes = try fileManager.attributesOfItem(atPath: url.path)
                            attributes[FileAttributeKey.protectionKey] = FileProtectionType.none
                            try fileManager.setAttributes(attributes, ofItemAtPath: url.path)
                        }
                    #endif
                } else {
                    if fileHandle == nil {
                        fileHandle = try FileHandle(forWritingTo: url as URL)
                    }
                    if let fileHandle = fileHandle {
                        _ = fileHandle.seekToEndOfFile()
                        let line = stringLog + "\n"
                        if let data = line.data(using: String.Encoding.utf8) {
                            fileHandle.write(data)
                        }
                    }
                }
            } catch {
                print("File Destination could not write to file \(url).")
            }
        }
    }
    
    public static func readLogs() {
        if let url = IOSLogger.logFileURL {
            var inString = ""
            do {
                inString = try String(contentsOf: url)
            } catch {
                print("Failed reading from URL: \(url), Error: " + error.localizedDescription)
            }
            print(inString)
        }
    }
    
    public static func sendLogs(viewController : UIViewController){
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = IOSLogger.instance
            mail.setToRecipients([IOSLogger.authorEmail])
            
            var attachmentData = Data()
            
            attachmentData.append(IOSLogger.getLogFileData())
            
            let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject
            let version = nsObject as? String
            let build = Bundle.main.infoDictionary?["CFBundleVersion"]  as? String
            let logFileName = "\(IOSLogger.appName) \(version ?? "1.0")(\(build ?? "1.0")).zip"
            
            mail.addAttachmentData(attachmentData, mimeType: "text/plain", fileName: logFileName)
            
            viewController.present(mail, animated: true)
        } else {
            print("MailComposerError")
        }
    }
    
    static func getLogFileData() -> Data {
        IOSLogger.i(textLog: "Zipping file logs")
        let zipFilePath = try? Zip.quickZipFiles([IOSLogger.logFileURL!], fileName: IOSLogger.appName)
        let logFileData = try? Data(contentsOf: zipFilePath!, options: .dataReadingMapped)
        return logFileData!
    }
    
}

extension IOSLogger : MFMailComposeViewControllerDelegate{
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

