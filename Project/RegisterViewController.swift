//
//  RegisterViewController.swift
//  Project
//
//  Created by NAM HYUNWOO on 26/10/20.
//  Copyright © 2020 NAM HYUNWOO. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPwd: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    
    var countID : Int = 0
    var RegUser: [NSManagedObject] = []
    
    @IBAction func btnCancel(_ sender: Any) {
        txtUserName.text = nil
        txtPassword.text = nil
        txtConfirmPwd.text = nil
        txtEmail.text = nil
        txtMobile.text = nil
    }
    @IBAction func btnLoginGo(_ sender: Any) {
        performSegue(withIdentifier: "backtoLogin", sender: self)
    }
    
    func SaveRecord() {
            let context = getContext()
            let entity = NSEntityDescription.entity(forEntityName: "Register", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            countID = countID + 1
            newUser.setValue(txtUserName.text, forKey: "username")
            newUser.setValue(txtPassword.text, forKey: "password")
            newUser.setValue(txtEmail.text, forKey: "email")
            newUser.setValue(txtMobile.text, forKey: "mobile")
            newUser.setValue(countID, forKey: "userid")
            print(countID)
            do{
                try context.save()
                 performSegue(withIdentifier: "Success", sender: self)
            }catch {
                print("Error : Failed")
            }
            
        }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return  appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func btmSubmit(_ sender: Any) {
        if (txtUserName.text == "") {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter valid User Name." ,action: false)
        }
        if (txtPassword.text == "") {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter valid Password.", action: false)
        }
        if (txtConfirmPwd.text == "") {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter valid ConfirmPassword.", action: false)
        }
        if (txtPassword.text != txtConfirmPwd.text) {
            showAlert(withTitleMessageAndAction: "Alert!", message: "ConfirmPassword does not match.", action: false)
        }
        if (txtEmail.text == "" ) {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter Email iD.", action: false)
        }
        if !check(forValidEmail: txtEmail) {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter valid Email id.", action: false)
        }
        if (txtMobile.text == "") {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter Mobile No.", action: false)
        }
        SaveRecord()
    }
    
    
    func check(forValidEmail textfield: UITextField) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        print(emailTest.evaluate(with: textfield.text!))
        return emailTest.evaluate(with: textfield.text!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(withTitleMessageAndAction title:String, message:String , action: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if action {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action : UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
        } else{
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
           
        }
        self.present(alert, animated: true, completion: nil)
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
