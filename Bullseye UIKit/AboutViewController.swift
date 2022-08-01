//
//  AboutViewController.swift
//  Bullseye UIKit
//
//  Created by Ardian Pramudya Alphita on 08/07/22.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "Bullseye", withExtension: "html") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    @IBAction func closeModal(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
