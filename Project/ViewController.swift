//
//  ViewController.swift
//  Project
//
//  Created by NAM HYUNWOO on 15/10/20.
//  Copyright © 2020 NAM HYUNWOO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //delete all records
    @IBAction func ClearRecords(_ sender: Any) {
        let alertContoller = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete All student Records?", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action:UIAlertAction!) in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.removeRecords();
        }
        
        alertContoller.addAction(OKAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertContoller.addAction(cancelAction)
        
        self.present(alertContoller,animated: true, completion: nil)
    }
    
    

    //Can delette
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

