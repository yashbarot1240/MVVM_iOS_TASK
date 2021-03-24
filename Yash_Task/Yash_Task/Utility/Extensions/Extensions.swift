//
//  Extensions.swift
//  Yash_Task
//
//  Created by DevstreeAir2 on 24/03/21.
//

import UIKit


extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).*$"
              let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)

              return passwordValidation.evaluate(with: self)
    }
    
    
    func convertIntoDate(formate : String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ")->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = formate
        return dateFormatter.date(from:self)
    }
}


extension  UIViewController {

    func showAlert(withTitle title: String = "Error", withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
//        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
//        })
        alert.addAction(ok)
//        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}



