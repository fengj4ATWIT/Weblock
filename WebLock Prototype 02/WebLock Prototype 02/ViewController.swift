//
//  ViewController.swift
//  WebLock Prototype 02
//
//  Created by allanshemah on 3/9/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignIn")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
            }
    
    
    @IBAction func createaccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUp")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
            }
}

