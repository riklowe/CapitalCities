//
//  MarkerAnnotationView.swift
//  CustomMapAnnotation
//
//  Created by Richard Lowe on 02/03/2018.
//  Copyright © 2019 Richard Lowe All rights reserved.
//

import Foundation
import MapKit

class MarkerAnnotationView : MKMarkerAnnotationView {

    // this class shows the annotation as a ballon
    // but only shows the title ans subtitle when selected
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.0, 0.0)
    var title: String = ""
    var subtitle: String? = ""

    override var annotation: MKAnnotation? {

        willSet {

            print ("***** MarkerAnnotationView \(#function) *****S")

            //clusteringIdentifier = "type2"

            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)

            //use an image in the callout
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "smile"), for: UIControl.State())

            rightCalloutAccessoryView = mapsButton

            //plain info button
//            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

            //format the annotation text
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = annotation?.subtitle!!
            detailCalloutAccessoryView = detailLabel

            markerTintColor = RandomFixedColor()
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
