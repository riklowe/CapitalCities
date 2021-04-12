//
//  myPointAnnotation.swift
//  CapitalCities
//
//  Created by Richard Lowe on 11/03/2019.
//  Copyright © 2019 Richard Lowe All rights reserved.
//

import Foundation
import MapKit


//open class MKPointAnnotation : MKShape {
//    open var coordinate: CLLocationCoordinate2D
//}

//open class MKShape : NSObject, MKAnnotation {
//    open var title: String?
//    open var subtitle: String?
//}

class MyPointAnnotation: MKPointAnnotation {

    var lon: String? = ""
    var lat: String? = ""
    var speed: String? = ""
    var course: String? = ""

    init (lon: String , lat: String , speed: String , course: String ) {
        self.lon = lon
        self.lat = lat
        self.speed = speed
        self.course = course
    }

}


