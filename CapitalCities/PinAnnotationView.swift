//
//  PinAnnotationView.swift
//  CustomMapAnnotation
//
//  Created by Richard Lowe on 02/03/2018.
//  Copyright © 2018 Richard Lowe All rights reserved.
//

import Foundation
import MapKit

class PinAnnotationView : MKPinAnnotationView {
    
    // this class shows the pin annotation as an image
    // but only shows the title and subtitle when selected
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.0, 0.0)
    var title: String = ""
    var subtitle: String? = ""
    
    override var annotation: MKAnnotation? {
        willSet {
            
            print ("***** PinAnnotationView \(#function) *****S")
            
//            if annotation?.title == "type3" {
//                clusteringIdentifier = "type3"
//            }
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            //plain info button
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

            //format the annotation text
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = annotation?.subtitle!!
            //print (detailLabel.text)
            detailCalloutAccessoryView = detailLabel
            
            print ("***** PinAnnotationView \(#function) *****E")

        }
    }
    
    override var isEnabled: Bool {
        willSet {
            //print ("***** PinAnnotationView \(#function) *****S")
        }
    }
    
    override var image: UIImage? {
        willSet {
            //print ("***** PinAnnotationView \(#function) *****S")
        }
    }
    
    override var isHighlighted: Bool {
        willSet {
            //print ("***** PinAnnotationView \(#function) *****S")
        }
    }
    
    override var centerOffset: CGPoint {
        willSet {
            //print ("***** PinAnnotationView \(#function) *****S")
        }
    }
    
    override var calloutOffset: CGPoint {
        willSet {
            //print ("***** PinAnnotationView \(#function) *****S")
        }
    }
}
