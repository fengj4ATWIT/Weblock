//
//  SignUpViewController.swift
//  WebLock Prototype 02
//
//  Created by allanshemah on 3/9/23.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func createaccountTapped(_ sender: Any) {
        if email.text?.isEmpty == true{
            print("no text in email field")
            return
        }
        if password.text?.isEmpty == true {
            print("no text in password field")
            return
        }
        signup()
    }
    func signup(){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else{
                print("error")
                return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Start")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
        
    }
    
}
