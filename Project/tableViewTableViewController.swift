//
//  tableViewTableViewController.swift
//  Project
//
//  Created by NAM HYUNWOO & XIANG YANMU on 15/10/20.
//  Copyright © 2020 NAM HYUNWOO & XIANG YANMU. All rights reserved.
//

import UIKit

class tableViewTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var stu_list_view: UITableView!
    
    var stu_list:[Int] = []
        var selected:Int = 39
        
}
