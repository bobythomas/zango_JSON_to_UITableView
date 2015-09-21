//
//  usermgr.swift
//  zango
//
//  Created by boby thomas on 2015-09-09.
//  Copyright (c) 2015 boby thomas. All rights reserved.
//

import Foundation

class userManager {
    
    class func getUserMgrInstace() ->userManager
    {
        if (userMgrInstance == nil)
        {
            userMgrInstance = userManager()
        }
        return userMgrInstance
    }
    
    
    func addUser(id : Int , name : String, username : String, email:String, addr : address, phone : String, webAddress : String, comp : company)
    {
        users.append(User(uID : id, uname : name, uUsername : username, emailaddress : email, uAddr : addr, uPhone : phone, webAddr : webAddress , uCompany : comp))
        //count++
    }
    func deleteUser(index: Int)
    {
        users.removeAtIndex(index)
    }
    func shuffleUserArray()
    {
        if users.count > 1
        {
            for var i=users.count-1 ; i>0 ; --i
            {
                //users.sort(<#isOrderedBefore: (T, T) -> Bool##(T, T) -> Bool#>)
                swap(&users[i], &users[Int(arc4random_uniform(UInt32(i)))])
            }
        }
    }
    func getCount() -> Int
    {
        return users.count
    }
    func getUser(index : Int)-> User
    {
        return users[index]
    }
    
    
    
    var users : [User] = [User]()
    var count : Int = 0
    var next : String?
    var previous : String?
    private static var userMgrInstance : userManager!
    
    
}

class User {
    
    init(uID : Int, uname : String, uUsername : String, emailaddress:String, uAddr : address, uPhone : String, webAddr : String , uCompany : company)
    {
        self.id = uID
        self.name = uUsername
        self.username = uUsername
        self.email = emailaddress
        self.addr = uAddr
        self.phone = uPhone
        self.website = webAddr
        self.addr = uAddr
        self.compny = uCompany
    }
    
    init()
    {
        id = 0
        name = ""
        username = ""
        email = ""
        phone = ""
        website = ""
        addr = address()
        compny = company()
    }
    
    var id : Int
    var name : String
    var username : String
    var email : String
    var phone : String
    var website : String
    var addr : address
    var compny : company
    
}

class address{
    
    init( streetname : String , suitnumber : String, cityname : String, zip : String, lattitude : Double, longitude : Double)
    {
        self.street = streetname
        self.suit = suitnumber
        self.city = cityname
        self.zipcod = zip
        self.lat = lattitude
        self.lng = longitude
    }
    
    init()
    {
        street = ""
        suit = ""
        city = ""
        zipcod = ""
        lat = 0
        lng = 0
    }
    
//    func toString() -> String
//    {
//        return suit + "," + street + "," + city + "," + zipcod
//    }
    var street : String
    var suit  : String
    var city : String
    var zipcod : String
    var lat : Double
    var lng : Double
    
}

class company{
    init( Cname : String , Cphrase : String, Cbs : String)
    {
        self.name = Cname
        self.catchphrase = Cphrase
        self.bs = Cbs
    }
    init()
    {
        name = ""
        catchphrase = ""
        bs = ""
    }
    var name : String
    var catchphrase : String
    var bs : String
}