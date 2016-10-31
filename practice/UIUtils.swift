//
//  UIUtils.swift
//  practice
//
//  Created by Radoljub Markovic on 10/31/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import Foundation
import UIKit

class UIUtils {
    
    static func createErrorAlertDialog(error: Error) -> UIAlertController {
        
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(
            title: "Ok",
            style: .default,
            handler: nil))
        
        return alertController
    }
}
