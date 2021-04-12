//
//  CustomPointAnnotation.swift
//  CapitalCities
//
//  Created by Richard Lowe on 08/03/2019.
//  Copyright © 2019 Richard Lowe All rights reserved.
//

import Foundation
import MapKit

class CustomPointAnnotation: MKPinAnnotationView {
    
    // this class shows the pin annotation as an image
    // but only shows the title and subtitle when selected
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.0, 0.0)
    var title: String = ""
    var subtitle: String? = ""
    
    override var annotation: MKAnnotation? {
        willSet {
            
            print ("***** CustomPointAnnotation \(#function) *****S")
            
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
            print (detailLabel.text as Any)
            
            let detailLabel1 = UILabel()
            detailLabel1.numberOfLines = 0
            detailLabel1.font = detailLabel.font.withSize(12)
            detailLabel1.text = annotation?.subtitle!!
            print (detailLabel1.text as Any)
            
            let detailView = UIView()
            detailView.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
            detailView.backgroundColor = .red
            detailView.addSubview(detailLabel)
            
            detailCalloutAccessoryView = detailView
            
            print ("***** CustomPointAnnotation \(#function) *****E")
            
        }
    }
    
    override var isEnabled: Bool {
        willSet {
            print ("*****  CustomPointAnnotation \(#function) *****S")
        }
    }
    
    override var image: UIImage? {
        willSet {
            print ("***** CustomPointAnnotation \(#function) *****S")
        }
    }
    
    override var isHighlighted: Bool {
        willSet {
            print ("***** CustomPointAnnotation \(#function) *****S")
        }
    }
    
    override var centerOffset: CGPoint {
        willSet {
            print ("***** CustomPointAnnotation \(#function) *****S")
        }
    }
    
    override var calloutOffset: CGPoint {
        willSet {
            print ("***** CustomPointAnnotation \(#function) *****S")
        }
    }
}
