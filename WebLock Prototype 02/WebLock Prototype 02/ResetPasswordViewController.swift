//
//  ResetPasswordViewController.swift
//  WebLock Prototype 02
//
//  Created by allanshemah on 3/12/23.
//

import UIKit
import FirebaseAuth
import Firebase

class ResetPasswordViewController: UIViewController {
    
    
    @IBOutlet var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func resetTapped(_ sender: Any) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: email.text!) { (error) in
            if let error = error {
                let alert = UIAlertController(title: "My Alert", message: "Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let alert = UIAlertController(title: "My Alert", message: "The password resent link was sent.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
}
