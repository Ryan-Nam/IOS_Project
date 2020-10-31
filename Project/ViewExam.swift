//
//  ViewExam.swift
//  Project
//
//  Created by NAM HYUNWOO on 21/10/20.
//  Copyright © 2020 NAM HYUNWOO. All rights reserved.
//

import UIKit
import Foundation

class ViewExam: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var notice_label: UILabel!
    @IBOutlet weak var exam_list_view: UITableView!
    
    
    var stu_id : Int = 0
    var exam_list_array:[String] = Array()
    let today = NSDate()
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exam_list_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tmp: String = ""
        let cell:UITableViewCell = exam_list_view.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = exam_list_array[indexPath.row]
        tmp = cell.textLabel!.text!
        tmp = tmp.components(separatedBy: ",")[1]

        // It will change data type, for example, string to date.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy HH:mm"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let exam_date = dateFormatter.date(from: tmp)
        
        // It will compare between exam data and today.
        if (exam_date! < today as Date){
            cell.textLabel!.textColor = UIColor.lightGray
        }
        return cell
    }
    
    // It enable mutiple check box for delete.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var str:String = ""
        
        if exam_list_view.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            exam_list_view.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            
        }else{
            exam_list_view.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        
        str = (exam_list_view.cellForRow(at: indexPath)?.textLabel!.text)!
        print(str)
        str = str.components(separatedBy: ",")[0]
        print(str)
        appDelegate.changeStatusColumn(unit_name: str)
        
    }
        
    @IBAction func deleteBtn(_ sender: Any) {
         let alertContoller = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this 'Exam Record'?", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action:UIAlertAction!) in
            print("OK button tapped");
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.deleteExamInfo()
        }
        
        alertContoller.addAction(OKAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertContoller.addAction(cancelAction)
        
        self.present(alertContoller,animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // It presents time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd/MM/yyyy"
        let dateString = dateFormatter.string(from: today as Date)
        notice_label.text = "The current time is \n" + dateString
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        exam_list_array = appDelegate.getExamArray(stu_id: stu_id)
    }
    
    // It will pass the student id to other pages
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "gotoEdit"){
            let DestViewController:EditStudent = segue.destination as! EditStudent
            DestViewController.stu_id = stu_id
        }
        if (segue.identifier == "gotoAddExam"){
            let DestViewController:AddExam = segue.destination as! AddExam
            DestViewController.stu_id = stu_id
        }
    }
}
