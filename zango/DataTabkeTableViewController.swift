//
//  DataTabkeTableViewController.swift
//  zango
//
//  Created by boby thomas on 2015-09-10.
//  Copyright (c) 2015 boby thomas. All rights reserved.
//

import UIKit

let JSONURL = "http://jsonplaceholder.typicode.com/users"

class DataTabkeTableViewController: UITableViewController {

    var userMgr : userManager = userManager.getUserMgrInstace()
    var selectedUsrIndex : Int = 0
    
    @IBOutlet weak var m_uiEditButton: UIBarButtonItem!
    
    var m_uiActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.editing = true
        self.tableView.registerClass(UserDetailsCell.self, forCellReuseIdentifier: "userdetails")
        //self.tableView.registerClass(AddressTableViewCell.self, forCellReuseIdentifier: "addresscell")
        var nib = UINib(nibName: "TableCellNib", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "userdetails")
        self.m_uiEditButton.tag = 0 // 0 - non editing mode , 1 - editing mode
        self.refreshControl?.addTarget(self, action: "reloadData", forControlEvents: .ValueChanged)
        m_uiActivityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        m_uiActivityIndicator.center = self.view.center
        m_uiActivityIndicator.hidesWhenStopped = true
        m_uiActivityIndicator.userInteractionEnabled = false
        m_uiActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.tableView.addSubview(m_uiActivityIndicator)
        m_uiActivityIndicator.startAnimating()
        reloadData2()
    }

    func reloadData()
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //2
            var session = NSURLSession.sharedSession()
            // Use NSURLSession to get data from an NSURL
            let loadDataTask = session.dataTaskWithURL(NSURL(string: JSONURL)!, completionHandler:
                {
                    (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                    if data != nil
                    {
                    self.updateTableData(data, error: error)
                        self.refreshControl?.endRefreshing()
                    }
                })
            
            loadDataTask.resume()
        })
    }
    func reloadData2()
    {
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //2
            var session = NSURLSession.sharedSession()
            // Use NSURLSession to get data from an NSURL
            let loadDataTask = session.dataTaskWithURL(NSURL(string: JSONURL)!, completionHandler:
                {
                    (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                    if data != nil
                    {
                        self.updateTableData(data, error: error)
                        self.refreshControl?.endRefreshing()
                    }
            })
            
            loadDataTask.resume()
        //})
        
    }
    
    func updateTableData(data: NSData!, error : NSError!)
    {
            // Get #1 app name using SwiftyJSON
//            let json = JSON(data: data)
//            let array = json["feed"]["entry"].array
//        
//            if let appName = json["feed"]["entry"][0]["im:username"]["label"].string {
//                println("SwiftyJSON: \(appName)")
//            }

        var error : NSError?
        //let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! [String : AnyObject]
        var jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers , error: &error)
        if (jsonResult != nil)
        {
            let jsonData:NSArray = ( jsonResult as? NSArray)!
            
            
            
            let nmFormater = NSNumberFormatter()
            for user in jsonData
            {
                
                let singleUser  = user as! NSDictionary
                let emailaddr: String = (singleUser["email"] as? String)!
                let name: String = (singleUser["name"] as? String)!
                let username: String = (singleUser["username"] as? String)!
                let phoneNumber: String = (singleUser["phone"] as? String)!
                let website : String = (singleUser["website"] as? String)!
                let id : Int = (singleUser["id"] as? Int)!
                let addressDic = (singleUser["address"] as! NSDictionary)
                
                let addressGeo = (addressDic["geo"] as! NSDictionary)
                
                let lng = nmFormater.numberFromString((addressGeo["lng"] as? String)!)?.doubleValue
                let lat = nmFormater.numberFromString((addressGeo["lat"] as? String)!)?.doubleValue
                let addressobj : address = address( streetname: (addressDic["street"] as? String)!,
                    suitnumber: (addressDic["suite"] as? String)!,
                    cityname: (addressDic["city"] as? String)!,
                    zip: (addressDic["zipcode"] as? String)!,
                    lattitude : lat!,
                    longitude : lng!
                )
                
                let companyDetails = (singleUser["company"] as! NSDictionary)
                let companyObj : company = company( Cname: (companyDetails["name"] as? String)!,
                    Cphrase: (companyDetails["catchPhrase"] as? String)!,
                    Cbs: (companyDetails["bs"] as? String)!
                )
                
                userMgr.addUser(id, name: name, username: username, email: emailaddr, addr: addressobj, phone: phoneNumber, webAddress : website, comp: companyObj)
            }
            userMgr.shuffleUserArray()
            
            self.tableView.reloadData()
        }
        m_uiActivityIndicator.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return userMgr.getCount()
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UserDetailsCell = tableView.dequeueReusableCellWithIdentifier("userdetails", forIndexPath: indexPath) as! UserDetailsCell

        // Configure the cell...
        var newUser : User = userMgr.getUser(indexPath.row)
        cell.name = "\(newUser.name)"
        cell.details = "User ID : \(newUser.id) \nUserName : \(newUser.username) \nEmail : \(newUser.email)"
         + "\nAddress : \(newUser.addr.city)\n  \(newUser.addr.street)\n  \(newUser.addr.zipcod)\n  "
        + "\nPhone : \(newUser.phone)"

        let frameworkBundle = NSBundle(forClass: DataTabkeTableViewController.self)
        
        let imagePath = frameworkBundle.pathForResource("person1", ofType: "png")
        if imagePath != nil {
            var result = UIImage(contentsOfFile: imagePath!)
        }
        
        let path = NSBundle.mainBundle().pathForResource("person1", ofType:"png") as String?
        let filename = "person\((arc4random_uniform(UInt32(7)))+1).png"
        let image = UIImage(named: filename)
        //let image2 = UIImage(named: "person2.png")
        
        cell.m_imgPerson.image = image
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedUsrIndex = indexPath.row
        performSegueWithIdentifier("details", sender: nil)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if .Delete == editingStyle
        {
            userMgr.deleteUser(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Middle)
            //self.tableView.reloadData()
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "details") {
            var svc = segue.destinationViewController as! DetailsTableViewController;
            svc.setCurrentUser(userMgr.getUser(selectedUsrIndex))
        }
    }
    
    @IBAction func OnPressEditButton(sender: UIBarButtonItem) {
        if self.navigationItem.rightBarButtonItem!.tag == 0 // now go to editing mode
        {
            self.tableView.editing = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "OnPressEditButton:")
            self.navigationItem.rightBarButtonItem!.tag = 1
        }
        else
        {
            self.tableView.editing = false
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "OnPressEditButton:")
            self.navigationItem.rightBarButtonItem!.tag = 0
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

}
