//
//  AnnotationView.swift
//  CustomMapAnnotation
//
//  Created by Richard Lowe on 26/06/2017.
//  Copyright © 2017 Richard Lowe All rights reserved.
//

import Foundation
import MapKit

class AnnotationView : MKAnnotationView {
    
    // this class shows the pin annotation as an image
    // but only shows the title ans subtitle when selected

    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.0, 0.0)
    var title: String = ""
    var subtitle: String? = ""
    
    override var annotation: MKAnnotation? {
        willSet {
            
            //print ("***** AnnotationView \(#function) *****S")

            clusteringIdentifier = "type1"
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            //plain info button
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                        
            //format the annotation text
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = "oooeeerrr misses"
            
            detailCalloutAccessoryView = detailLabel
            
        }
    }
    
    override var isEnabled: Bool {
        willSet {
            print ("***** AnnotationView \(#function) *****S")
        }
    }
    
    override var image: UIImage? {
        willSet {
            print ("***** AnnotationView \(#function) *****S")
        }
    }
    
    override var isHighlighted: Bool {
        willSet {
            print ("***** AnnotationView \(#function) *****S")
        }
    }
    
    override var centerOffset: CGPoint {
        willSet {
            print ("***** AnnotationView \(#function) *****S")
        }
    }
    
    override var calloutOffset: CGPoint {
        willSet {
            print ("***** AnnotationView \(#function) *****S")
        }
    }
}


