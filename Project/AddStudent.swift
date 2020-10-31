//
//  AddStudent.swift
//  Project
//
//  Created by NAM HYUNWOO on 15/10/20.
//  Copyright © 2020 NAM HYUNWOO. All rights reserved.
//

import UIKit

class AddStudent: UIViewController {

    // Variables
    @IBOutlet weak var id_txt: UITextField!
    @IBOutlet weak var first_name_txt: UITextField!
    @IBOutlet weak var last_name_txt: UITextField!
    @IBOutlet weak var gender_seg: UISegmentedControl!
    @IBOutlet weak var course_txt: UITextField!
    @IBOutlet weak var age_label: UILabel!
    @IBOutlet weak var age_stepper: UIStepper!
    @IBOutlet weak var address_txt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        age_stepper.wraps = true
        age_stepper.autorepeat = true
        age_stepper.maximumValue = 99
    }
    
    @IBAction func StepperChanged(_ sender: Any) {
        let step = Int(age_stepper.value)
        age_label.text = String(step)
    }
    
    @IBAction func SaveDataBtn(_ sender: Any) {
        let genderStr:String
         
         if self.gender_seg.selectedSegmentIndex == 0 {
             genderStr = "Male"
         } else {
             genderStr = "Female"
         }
         
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         
         appDelegate.storeStuInfo(student_id: Int (id_txt.text!)!, first_name: first_name_txt.text!, last_name: last_name_txt.text!, gender: genderStr, course_study: course_txt.text!, age: Int(age_label.text!)!, address: address_txt.text!)
        
         showAlert(msg: "Your record is sucessfully saved")
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Message", message: msg, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion:nil)
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
