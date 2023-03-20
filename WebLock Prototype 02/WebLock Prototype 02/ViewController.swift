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
    
    
    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        
        struct SwiftUIView: View {
            var body: some View {
                ZStack {
                    Color.pink
                    Button("Hello, SwiftUI!") {
                        
                    }
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .navigationTitle("SwiftUI View")
            }
        }
        
        return  UIHostingController(coder: coder, rootView: SwiftUIView())
    }
    
}

