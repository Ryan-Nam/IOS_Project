//
//  WebViewController.swift
//  Project
//
//  Created by NAM HYUNWOO on 26/10/20.
//  Copyright © 2020 NAM HYUNWOO. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let myURL = URL (string:"https://www.westernsydney.edu.au") {
                 let myURLRequest = URLRequest(url:myURL)
                 webView.load(myURLRequest)
             }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
