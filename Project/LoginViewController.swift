//
//  LoginViewController.swift
//  Project
//
//  Created by NAM HYUNWOO on 26/10/20.
//  Copyright © 2020 NAM HYUNWOO. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var RegList = NSArray()
    var ctrVariable : Int = 0
    
    
    //When "Register is touched, Move to Login
    @IBAction func btnregister(_ sender: Any) {
        performSegue(withIdentifier: "movetoLogin", sender: self)
    }
    
    func getContext() -> NSManagedObjectContext
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    func GetDataFromDB()
        {
            let context = getContext()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
            let predicate = NSPredicate(format: "username =%@", txtUserName.text!, "password =%@", txtPassword.text!)
            fetchRequest.predicate = predicate
            do {
                RegList = try context.fetch(fetchRequest) as NSArray
               // print(RegList.count)
                if RegList.count > 0 {
                  //  print(RegList.count)
                    let objectentity = RegList.firstObject as! Register
                    if ((txtUserName.text == objectentity.username) && (txtPassword?.text == objectentity.password))
                       
                        {
                              performSegue(withIdentifier: "movetoHome", sender: self)
                        }
                        else
                        {
                            print(objectentity.username as Any)
                            print(objectentity.password as Any)
                            print("does not Match!!")
                            showAlert(withTitleMessageAndAction: "Alert", message: "UserName and Password does not match!!", action: false)
                        }
                    }

                }catch let error as NSError{
                    print("Could not Fetch, \(error)")
            }
        }
    
    
    func showAlert(withTitleMessageAndAction title:String, message:String , action: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if action {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action : UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
        } else{
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func btnLogin(_ sender: Any) {
        if (txtUserName.text == ""){
            showAlert(withTitleMessageAndAction: "Alert", message: "Please Enter UserName", action: false)
        }
        if (txtPassword.text == ""){
            showAlert(withTitleMessageAndAction: "Alert", message: "Please Enter Password", action: false)
        }
        GetDataFromDB()
        /*
         Not insert here, have to insert into "getDataFrom DB" for path
         performSegue(withIdentifier: "movetoHome", sender: self)
 */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
