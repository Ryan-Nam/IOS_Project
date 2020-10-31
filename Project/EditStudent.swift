//
//  EditStudent.swift
//  Project
//
//  Created by NAM HYUNWOO on 21/10/20.
//  Copyright © 2020 NAM HYUNWOO. All rights reserved.
//

import UIKit

class EditStudent: UIViewController {

    @IBOutlet weak var stu_id_label: UILabel!
    @IBOutlet weak var first_name_txt: UITextField!
    @IBOutlet weak var last_name_txt: UITextField!
    @IBOutlet weak var gender_seg: UISegmentedControl!
    @IBOutlet weak var course_txt: UITextField!
    @IBOutlet weak var age_label: UILabel!
    @IBOutlet weak var age_stepper: UIStepper!
    @IBOutlet weak var address_txt: UITextField!
    
    var stu_id:Int = 0
    
    @IBOutlet weak var showMapBtn: UIBarButtonItem!
    
    @IBAction func showOnMapPressed(_ sender: Any) {
        shouldPerformSegue(withIdentifier: "navToMaos", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        age_stepper.wraps = true
        age_stepper.autorepeat = true
        age_stepper.maximumValue = 99
        
        stu_id_label.text = String(stu_id)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        first_name_txt.text = appDelegate.getStuColumn(stu_id: stu_id, col: "first_name")
        last_name_txt.text = appDelegate.getStuColumn(stu_id: stu_id, col: "last_name")
        course_txt.text = appDelegate.getStuColumn(stu_id: stu_id, col: "course_study")
        age_label.text = appDelegate.getStuColumn(stu_id: stu_id, col: "age")
        address_txt.text = appDelegate.getStuColumn(stu_id: stu_id, col: "address")
        
        if (appDelegate.getStuColumn(stu_id: stu_id, col: "gender") == "Male"){
            gender_seg.selectedSegmentIndex = 0
        } else {
            gender_seg.selectedSegmentIndex = 1
        }
    }
    

    @IBAction func StepperChanged(_ sender: Any) {
        let step = Int(age_stepper.value)
        age_label.text = String(step)
    }
    
    @IBAction func EditBtn(_ sender: Any) {
    let genderStr:String
    
    if self.gender_seg.selectedSegmentIndex == 0 {
        genderStr = "Male"
    } else {
        genderStr = "Female"
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    appDelegate.updateStuInfo(student_id: stu_id, first_name: first_name_txt.text!, last_name: last_name_txt.text!, gender: genderStr, course_study: course_txt.text!, age: Int(age_label.text!)!, address: address_txt.text!)
    
     showAlert(msg: "Your record is sucessfully Updated")
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Message", message: msg, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion:nil)
    }
    
    @IBAction func DeleteBtn(_ sender: Any) {
        
        let alertContoller = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this 'Studnet Record'?", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action:UIAlertAction!) in
            print("OK button tapped");
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.deleteStuInfo(stu_id: self.stu_id)
        }
        
        alertContoller.addAction(OKAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertContoller.addAction(cancelAction)
        
        self.present(alertContoller,animated: true, completion: nil)
    }
    
    
    //passing the stu_id to other pages
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "navToMaps")
        {
            let vc = segue.destination as! MapViewController
            vc.location = address_txt.text!
        }
        
        if (segue.identifier == "gotoAddExam")
        {
            let DestViewController:AddExam = segue.destination as! AddExam
            DestViewController.stu_id = stu_id
        }
        if (segue.identifier == "gotoViewExam")
        {
            let DestViewController:ViewExam = segue.destination as! ViewExam
            DestViewController.stu_id = stu_id
        }
    }
}
