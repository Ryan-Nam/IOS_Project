//
//  SelectStudent.swift
//  Project
//
//  Created by NAM HYUNWOO on 15/10/20.
//  Copyright © 2020 NAM HYUNWOO. All rights reserved.
//

import UIKit

class SelectStudent: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var stu_list_view: UITableView!
    
    var stu_list:[Int] = []
    var selected:Int = 39
    
    //setting table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stu_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = stu_list_view.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel!.text = String (stu_list[indexPath.row])
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        stu_list_view.deselectRow(at: indexPath, animated: true)
    }
    
    
    //passing the stu_id to other pages
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "gotoEdit"){
            let DestViewController:EditStudent = segue.destination as! EditStudent
            let index = stu_list_view.indexPathForSelectedRow?.row
            DestViewController.stu_id = stu_list[index!]
        }
    }
    

    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        stu_list = appDelegate.getStuIdArray()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
