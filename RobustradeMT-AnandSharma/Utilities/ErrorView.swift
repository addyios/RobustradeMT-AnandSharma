//
//  ErrorView.swift
//  RobustradeMT-AnandSharma
//
//  Created by APPLE on 03/01/26.
//

import Foundation
import UIKit

extension UIViewController {

    func showAlert(
        title: String = "Error",
        message: String,
        retryHandler: (() -> Void)? = nil
    ) {

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        if let retryHandler = retryHandler {
            alert.addAction(
                UIAlertAction(title: "Retry", style: .default) { _ in
                    retryHandler()
                }
            )
        }
        present(alert, animated: true)
    }
}
