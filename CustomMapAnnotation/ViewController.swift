//
//  ViewController.swift
//  CustomMapAnnotation
//
//  Created by Richard Lowe on 26/06/2017.
//  Copyright © 2017 Richard Lowe All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    
    @IBOutlet weak var button2: UIButton!
    @IBOutlet var button: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet var mapView: MKMapView!
    
    var locationManager: CLLocationManager?
    var currentLocation: MKUserLocation? {
        didSet {
            button.isHidden = (currentLocation == nil)
        }
    }

    lazy var formatter: DateFormatter = {
        print ("***** \(#function) *****")
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateStyle = DateFormatter.Style.short
        return formatter
    }()

    override func viewDidLoad() {
        print ("***** \(#function) *****")
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled() {

            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest

            switch CLLocationManager.authorizationStatus() {

            case .authorizedAlways, .authorizedWhenInUse:
                locationManager?.startUpdatingLocation()
                mapView.showsUserLocation = true

            default:
                locationManager?.requestWhenInUseAuthorization()
            }
        }
        
        registerAnnotationViewClasses()
        
        mapView.mapType = MKMapType.standard
        //mapView.mapType = MKMapType.mutedStandard
        //mapView.mapType = MKMapType.satellite
        
    }
    
    
    @IBAction func addPinTapped(_ sender: UIButton) {
        print ("***** \(#function) *****")
        
        guard let coordinate = currentLocation?.coordinate else {
            return
        }
        
        let reportTime = NSDate()
        let formattedTime = formatter.string(from: reportTime as Date)
        
        let rand = Double(Float(arc4random()) / 0xFFFFFFFF) - 0.5
        let rand2 = Double(Float(arc4random()) / 0xFFFFFFFF) - 0.5
        //print (rand)
        
        let annotation = MKPointAnnotation()
        
        annotation.title = "type2"
        annotation.subtitle = formattedTime
        annotation.coordinate = CLLocationCoordinate2D(latitude : coordinate.latitude + rand, longitude: coordinate.longitude + rand2)
        
        mapView.addAnnotation(annotation)

        
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        print ("***** \(#function) *****")
        
        guard let coordinate = currentLocation?.coordinate else {
            return
        }

        let reportTime = NSDate()
        let formattedTime = formatter.string(from: reportTime as Date)
        
        let rand = Double(Float(arc4random()) / 0xFFFFFFFF) - 0.5
        let rand2 = Double(Float(arc4random()) / 0xFFFFFFFF) - 0.5
        //print (rand)
        
        let annotation = MKPointAnnotation()
        annotation.title = "type1"
        annotation.subtitle = formattedTime
        annotation.coordinate = CLLocationCoordinate2D(latitude : coordinate.latitude + rand, longitude: coordinate.longitude + rand2)

        mapView.addAnnotation(annotation)
    }
    
    @IBAction func button3Tapped(_ sender: UIButton) {
        
        print ("***** \(#function) *****")
        
        guard let coordinate = currentLocation?.coordinate else {
            return
        }
        
        let reportTime = NSDate()
        let formattedTime = formatter.string(from: reportTime as Date)
        
        let rand = Double(Float(arc4random()) / 0xFFFFFFFF) - 0.5
        let rand2 = Double(Float(arc4random()) / 0xFFFFFFFF) - 0.5
        //print (rand)
        
        let annotation = MKPointAnnotation()
        annotation.title = "type3"
        annotation.subtitle = formattedTime
        annotation.coordinate = CLLocationCoordinate2D(latitude : coordinate.latitude + rand, longitude: coordinate.longitude + rand2)
        
        mapView.addAnnotation(annotation)

    }
    
    
    func registerAnnotationViewClasses() {
        print ("***** \(#function) *****")
        
        //show image as annotation
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        //show balloon as annotation AND all titles
        mapView.register(MarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

    }

}

extension ViewController : MKMapViewDelegate {
   
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //print ("***** \(#function) *****")
        currentLocation = userLocation
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is MKUserLocation {
            return nil
        }
        
        var pinView : MKAnnotationView!

        switch annotation.title {
        case "type1" :
            let reuseId = "a"
            pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            if pinView == nil {
                pinView = AnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.canShowCallout = true
            } else {
                pinView?.annotation = annotation
            }

            // get image to use as annotation and resize
            let pinImage = UIImage(named: "smile")
            let size = CGSize(width: 20, height: 20)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            pinView.image = resizedImage

        case "type2" :
            let reuseId = "b"
            pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            if pinView == nil {
                pinView = MarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.canShowCallout = true
            } else {
                pinView?.annotation = annotation
            }
            
        case "type3" :
            let reuseId = "c"
            pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            if pinView == nil {
                pinView = PinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.canShowCallout = true
            } else {
                pinView?.annotation = annotation
            }

        default :
            break
        }

        //let strWidth = (annotation.title!?.width(withConstrainedHeight: 20, font: .systemFont(ofSize: 10)))! + 10
        let strWidth = 50

        let lblTitle = UILabel(frame: CGRect(x: -15, y: -30, width: strWidth, height: 20))
        lblTitle.font = lblTitle.font.withSize(10)
        lblTitle.text = annotation.title!
        lblTitle.numberOfLines = 1
        lblTitle.textAlignment = NSTextAlignment.center
        lblTitle.textColor = UIColor.black
        lblTitle.backgroundColor = UIColor(red: 0.0, green: 0.9, blue: 0.0, alpha: 0.5)
        
        lblTitle.layer.cornerRadius = 6.0
        lblTitle.layer.borderWidth = 1.0
        lblTitle.layer.borderColor = UIColor.black.cgColor
        
        pinView.addSubview(lblTitle)
        
        return pinView

    }
}


extension ViewController : CLLocationManagerDelegate {
  
    //func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print ("***** \(#function) *****")
        switch status {
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
            mapView.showsUserLocation = true
            
        case .denied, .restricted:
            locationManager?.startUpdatingLocation()
            mapView.showsUserLocation = false
            currentLocation = nil
            
        default:
            currentLocation = nil
        }
    }
}
