//
//  AlertsController.swift
//  Weathered
//
//  Created by Michael Amiro on 04/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation
import UIKit

class AlertsController {
    /// Takes a string argument and returns a concatenated
    /// String.
    ///
    /// - Parameter errorMessage: A string explaining the error
    /// - Returns: UIAlertController with one Button
    func generateAlert(withError errorMessage: String) -> UIAlertController {
        let alert = UIAlertController(title: "Oooops", message: "\(errorMessage)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (_ ) in
            
        }))
        return alert
    }
}
