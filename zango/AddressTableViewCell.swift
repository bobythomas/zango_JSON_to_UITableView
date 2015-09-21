//
//  AddressTableViewCell.swift
//  zango
//
//  Created by boby thomas on 2015-09-17.
//  Copyright (c) 2015 boby thomas. All rights reserved.
//

import UIKit
import MapKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    private var m_strAddress : String = "";
    private var m_lat : Double = 43.741106
    private var m_lng : Double = -79.312725
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //var locationpoint = CLLocation(latitude: m_lat, longitude: m_lng)
        let delaytime = dispatch_time(DISPATCH_TIME_NOW, Int64( 2 * Double(NSEC_PER_SEC)))
        dispatch_after(delaytime, dispatch_get_main_queue(), {
            self.focusMaptoPoint()
        })
        
    }

    func focusMaptoPoint()
    {
        var locationpoint = CLLocation(latitude: m_lat, longitude: m_lng)
        var pointCoverDistance : CLLocationDistance = 1000
        let region = MKCoordinateRegionMakeWithDistance(locationpoint.coordinate, pointCoverDistance * 2, pointCoverDistance * 2)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAddress(addrString : String)
    {
        m_strAddress = addrString
    }
    
    func setLatLng(lattitude : Double, longitude : Double)
    {
        self.m_lat = lattitude
        self.m_lng = longitude
    }
}
