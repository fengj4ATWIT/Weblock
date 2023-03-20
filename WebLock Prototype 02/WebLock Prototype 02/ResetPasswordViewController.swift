//
//  ResetPasswordViewController.swift
//  WebLock Prototype 02
//
//  Created by allanshemah on 3/12/23.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet var newpassword: UITextField!
    
    @IBOutlet var confirmpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func resetTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Start")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)

    }
    
}
