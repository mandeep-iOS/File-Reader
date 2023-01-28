//
//  CustomButton.swift
//  File Reader
//
//  Created by Deep Baath on 28/01/23.
//

import UIKit

class CustomButton {
    ///MARK : static function called "changeButtonState" that takes three arguments: _title, color, button and update button UI accordingly
    static func changeButtonState(_title: String, color: UIColor, button: UIButton){
        button.setTitle(_title, for: .normal)
        button.backgroundColor = color
    }
}
