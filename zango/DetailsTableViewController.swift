//
//  DetailsTableViewController.swift
//  zango
//
//  Created by boby thomas on 2015-09-17.
//  Copyright (c) 2015 boby thomas. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    private var m_CurrentUser : User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.registerClass(AddressTableViewCell.self, forCellReuseIdentifier: "addresscell")
        var nibaddresscell = UINib(nibName: "AddressTableViewCell", bundle: nil)
        var nibdetailscell = UINib(nibName: "DetailsTableViewCell", bundle: nil)
        
        self.tableView.registerNib(nibaddresscell, forCellReuseIdentifier: "addresscell")
        self.tableView.registerNib(nibdetailscell, forCellReuseIdentifier: "detailscell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var strTitle : String = ""
        switch(section)
        {
        case 0:
            strTitle = "Address"
            break;
        case 1:
            strTitle = "Phone"
            break;
        case 2:
            strTitle = "Website"
            break;
        case 3:
            strTitle = "Company"
            break;
        default:
            break;
        }
        return strTitle
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!// = UITableViewCell()
        
        if 0 == indexPath.section
        {
            cell = tableView.dequeueReusableCellWithIdentifier("addresscell", forIndexPath: indexPath) as! UITableViewCell
            
            (cell as! AddressTableViewCell).setLatLng(m_CurrentUser.addr.lat, longitude: m_CurrentUser.addr.lng)
        }
        else
        {
            cell = tableView.dequeueReusableCellWithIdentifier("detailscell", forIndexPath: indexPath) as! DetailsTableViewCell
            if 1 == indexPath.section
            {
                (cell as! DetailsTableViewCell).m_text = "CellPhone : \(m_CurrentUser.phone)"
            }
            else if 2 == indexPath.section
            {
                (cell as! DetailsTableViewCell).m_text = m_CurrentUser.website
            }
            else if 3 == indexPath.section
            {
                (cell as! DetailsTableViewCell).m_text = "\(m_CurrentUser.compny.name) \n   \(m_CurrentUser.compny.catchphrase) \n  \(m_CurrentUser.compny.bs)"
            }
        }

        return cell
        // Configure the cell...

        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var rowHeight : CGFloat = 30;
        switch(indexPath.section)
        {
        case 0:
            rowHeight = 390
            break;
        default:
            rowHeight = 100
            break;
        }
        return rowHeight
    }
    
    func setCurrentUser( curUser : User)
    {
        self.m_CurrentUser = curUser
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if 1 == indexPath.section
        {
            var url:NSURL = NSURL(string: "tel://\(m_CurrentUser.phone)")!
            UIApplication.sharedApplication().openURL(url)
        }
        else if 2 == indexPath.section
        {
            var url:NSURL = NSURL(string: "http://\(m_CurrentUser.website)")!
            UIApplication.sharedApplication().openURL(url)
        }
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
