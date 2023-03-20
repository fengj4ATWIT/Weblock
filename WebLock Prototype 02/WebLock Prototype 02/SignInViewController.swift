//
//  SignInViewController.swift
//  WebLock Prototype 02
//
//  Created by allanshemah on 3/9/23.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserInfo()
    }

    
    @IBAction func signinTapped(_ sender: Any) {
       validateFields()
        
    }
    func validateFields(){
        if email.text?.isEmpty == true{
            print("no text in email field")
            return
        }
        if password.text?.isEmpty == true {
            print("no text in password field")
            return
        }
        login()
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] authResult, error in
            guard let strongself = self else{return}
            if let error = error {
                print(error.localizedDescription)
            }
            self!.checkUserInfo()
        }
        
    }
    func checkUserInfo(){
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Home Page")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
}
