//
//  CustomAlert.swift
//  File Reader
//
//  Created by Deep Baath on 28/01/23.
//

import UIKit

///MARK: The "AlertMessage" enum is used to define a set of predefined error messages that can be used throughout the application. Each case of the enumeration is defined as a string constant, which can be accessed using the dot-notation (e.g. AlertMessage.pdfEmpty).
enum AlertMessage: String {
    case pdfEmpty = "Please add File using import PDF."
    case speechRunning = "Please stop speech using Text-Speech then you can import another File."
    case cannotDelete = "Can't delete during running speech, Please stop speech using Text-Speech."
    case deleteExistingFile = "Please delete existing File using delete icon then imprt new File."
}

///MARK:  CustomAlert class is used to show the alert messages defined in the AlertMessage enum.
class CustomAlert: UIAlertController {
    
    func show(in viewController: UIViewController, alertMessage: String) {
        let alert = UIAlertController(title: alertMessage, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
