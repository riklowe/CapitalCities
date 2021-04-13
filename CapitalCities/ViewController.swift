//
//  ViewController.swift
//  CustomMapAnnotation
//
//  Created by Richard Lowe on 02/03/2018.
//  Copyright © 2019 Richard Lowe All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

func RunAfterDelay(_ delay: TimeInterval, block: @escaping () -> Void) {
    let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time, execute: block)
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    @IBAction func button1_action(_ sender: UIButton) {
        
        mapTypeCounter = mapTypeCounter + 1
        if mapTypeCounter > 5 {
            mapTypeCounter = 0
        }
        
        var mapLabel = ""
        
        switch mapTypeCounter {
        case 0:
            mapView.mapType = MKMapType.standard
            mapLabel = "Standard"
        case 1:
            mapView.mapType = MKMapType.mutedStandard
            mapLabel = "Muted Standard"
        case 2:
            mapView.mapType = MKMapType.hybrid
            mapLabel = "Hybrid Map"
        case 3:
            mapView.mapType = MKMapType.hybridFlyover
            mapLabel = "Hybrid Flyover"
        case 4:
            mapView.mapType = MKMapType.satellite
            mapLabel = "Satellite"
        case 5:
            mapView.mapType = MKMapType.satelliteFlyover
            mapLabel = "Satellite Flyover"
        default:
            break
        }
        
        button1.setTitle(mapLabel, for: .normal)
        
    }
    
    
    @IBAction func button2Action(_ sender: UIButton) {
        
        if allLabels == true {
            allLabels = false
            
            button2.setTitle("Labels OFF", for: .normal)
        } else {
            allLabels = true
            button2.setTitle("Labels ON", for: .normal)
        }
        
        refreshCities()
        
        //removeAnnotationLabels()
    }
    
    @IBOutlet var mapView: MKMapView!
    
    var locationManager: CLLocationManager?
    var currentLocation: MKUserLocation?
    var mapTypeCounter = 0
    var allLabels = false
    
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
        
        //registerAnnotationViewClasses()
        
        mapView.mapType = MKMapType.standard
        
        addCapitalCities()
        
    }
    
    func refreshCities() {
        print ("***** \(#function) *****")
        
        
        print ("***** REMOVE ANNOTATION *****")
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        print ("***** FINISHED *****")
        addCapitalCities()
        
    }
    
    func addCapitalCities() {
        
        print ("***** \(#function) *****")
        for city in cities {
            let result = city.split(separator: ",")
            
            //     Country,   Capital,   Latitude,  Longitude
            //print (result[0], result[1], result[2], result[3])
            
            print ("++++++++++++++++++++++++++++++++++++++++++++++")
            print (">>>>> create annotation")
            
            //let annotation = MKPointAnnotation()
            let annotation = MyPointAnnotation(lon:  String(result[3]), lat: String(result[2]) , speed: "7.3", course: "98.0")
            //let annotation = MKPointAnnotation()
            
            print (">>>>> set title")
            annotation.title = String(result[0]) //country
            
            print (">>>>> set subtitle")
            annotation.subtitle = String(result[1]) //captial city
            
            print (">>>>> set location")
            annotation.coordinate = CLLocationCoordinate2D(latitude : Double(result[2])!, longitude: Double(result[3])!)
            
            print (">>>>> add to map")
            mapView.addAnnotation(annotation)
            
            //view.detailCalloutAccessoryView?.backgroundColor = UIColor.red
            
            //break
        }
        
        
    }
    
    func registerAnnotationViewClasses() {
        print ("***** \(#function) *****")
        
        //show image as annotation
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        //show balloon as annotation AND all titles
        mapView.register(MarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        //show PIN as annotation AND all titles
        mapView.register(PinAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
    }
    
}

extension ViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //print ("***** \(#function) *****")
        currentLocation = userLocation
    }
    
    fileprivate func addAlwaysOnLabel(_ annotation: MKAnnotation, _ pinView: MKAnnotationView?) {
        //
        //Add Always On Label to annotation
        //
        print (">>>>> add label")
        
        for view in pinView!.subviews {
            view.removeFromSuperview()
        }
        
        if allLabels == true {
            if annotation.subtitle! != nil {
                let strTitle = String(annotation.subtitle!!)
                let strWidth = strTitle.size(OfFont: .systemFont(ofSize: 10)).width // size: {w: 98.912 h: 14.32}
                
                let lblTitle = UILabel(frame: CGRect(x: -(strWidth/2), y: -30, width: strWidth + 20, height: 20))
                lblTitle.font = lblTitle.font.withSize(10)
                lblTitle.text = annotation.subtitle!
                lblTitle.numberOfLines = 1
                lblTitle.textAlignment = NSTextAlignment.center
                lblTitle.textColor = UIColor.black
                
                lblTitle.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
                
                lblTitle.layer.cornerRadius = 6.0
                lblTitle.layer.borderWidth = 1.0
                lblTitle.layer.borderColor = UIColor.black.cgColor
                lblTitle.layer.masksToBounds = true
                
                print (">>>>> add label to pinView")
                
                pinView!.addSubview(lblTitle)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        print ("***** \(#function) \(String(describing: annotation.subtitle)) *****")

        if annotation is MKUserLocation {
            print (">>>>> user location found")
            return nil
        }

        var av = mapView.dequeueReusableAnnotationView(withIdentifier: "id")
        if av == nil {
            av = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
        }

        av?.tag = 1
        
        if (annotation is MyPointAnnotation) {

//            var speed = ""
//            var course = ""
            var lat = ""
            var lon = ""


            print ("Set variables")
//            course = (annotation as! MyPointAnnotation).course!
//            speed = (annotation as! MyPointAnnotation).speed!
            lat = (annotation as! MyPointAnnotation).lat!
            lon = (annotation as! MyPointAnnotation).lon!

            let detailAccessoryView = UIView()
            detailAccessoryView.backgroundColor = .red

            detailAccessoryView.tag = 2
            
            let subtitleStr = annotation.subtitle!
            let subtitleWidth = subtitleStr?.width(withConstrainedHeight: 20, font: UIFont.systemFont(ofSize: 17.0))
            
            let lonStr = "lon:" + lon
            let lonWidth = lonStr.width(withConstrainedHeight: 20, font: UIFont.systemFont(ofSize: 12.0))
            
            let labelWidth = max(Int(subtitleWidth!),Int(lonWidth)) + 20
            
            let widthConstraint = NSLayoutConstraint(item: detailAccessoryView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(labelWidth))
            detailAccessoryView.addConstraint(widthConstraint)

            let heightConstraint = NSLayoutConstraint(item: detailAccessoryView, attribute:   .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
            detailAccessoryView.addConstraint(heightConstraint)

            //let anno = annotation as! MyPointAnnotation

            av!.detailCalloutAccessoryView = detailAccessoryView
            
            av!.detailCalloutAccessoryView!.tag = 3
            
            av!.canShowCallout = true
            av!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            //av!.rightCalloutAccessoryView!.backgroundColor = .brown
            //av?.backgroundColor = .green
            
            av!.detailCalloutAccessoryView?.backgroundColor = .orange

            let label1 = UILabel()
            label1.frame = CGRect(x: 0, y: 0, width: labelWidth, height: 20)
            label1.text = annotation.subtitle!
            label1.backgroundColor = .clear
            label1.tag = 4
            detailAccessoryView.addSubview(label1)
            
            //print (label1.font.pointSize)
            //print (label1.font.fontName)

            let label2 = UILabel()
            label2.frame = CGRect(x: 0, y: 20, width: labelWidth , height: 20)
            label2.text = "lon:" + lon
            label2.font = UIFont.systemFont(ofSize: 12.0)
            label2.backgroundColor = .clear
            label2.tag = 5
            detailAccessoryView.addSubview(label2)

            let label3 = UILabel()
            label3.frame = CGRect(x: 0, y: 40, width: labelWidth, height: 20)
            label3.text = "lat:" + lat
            label3.font = UIFont.systemFont(ofSize: 12.0)
            label3.backgroundColor = .clear
            label3.tag = 6
            detailAccessoryView.addSubview(label3)

            detailAccessoryView.backgroundColor = .clear

//            let label4 = UILabel()
//            label4.frame = CGRect(x: 0, y: 40, width: 85, height: 20)
//            label4.text = "speed:" + speed
//            label4.font = UIFont.systemFont(ofSize: 12.0)
//            label4.backgroundColor = .white
//            myView.addSubview(label4)
//
//            let label5 = UILabel()
//            label5.frame = CGRect(x: 95, y: 40, width: 85, height: 20)
//            label5.text = "course:" + course
//            label5.font = UIFont.systemFont(ofSize: 12.0)
//            label5.backgroundColor = .white
//            myView.addSubview(label5)

        }

        //newDetailView(annotationView: annotationView!)

        addAlwaysOnLabel(annotation, av)
        
        //configureDetailView(annotationView: av!)

        return av!

    }
    
    
    func newDetailView(annotationView: MKAnnotationView) {
        
        print ("***** \(#function) *****S")
        let width = 300
        let height = 200
        
        let snapshotView = UIView()
        
        let views = ["snapshotView": snapshotView]
        snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[snapshotView(300)]", options: [], metrics: nil, views: views))
        snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[snapshotView(200)]", options: [], metrics: nil, views: views))
        
        let options = MKMapSnapshotter.Options()
        options.size = CGSize(width: width, height: height)
        options.mapType = .satelliteFlyover
        options.camera = MKMapCamera(lookingAtCenter: annotationView.annotation!.coordinate, fromDistance: 1000, pitch: 0, heading: 0)
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            if snapshot != nil {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
                imageView.image = snapshot!.image
                snapshotView.addSubview(imageView)
            }
        }
        
        annotationView.detailCalloutAccessoryView = snapshotView
        print ("***** \(#function) *****E")
    }
    
    
    func configureDetailView(annotationView: MKAnnotationView) {
        
        print ("***** \(#function) *****S")
        
        print (annotationView.annotation?.coordinate as Any)
        
        guard let coords = annotationView.annotation?.coordinate else { return }
        
        let width = 300
        let height = 200
        
        let snapshotView = UIView()
        
        let views = ["snapshotView": snapshotView]
        snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[snapshotView(300)]", options: [], metrics: nil, views: views))
        snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[snapshotView(200)]", options: [], metrics: nil, views: views))
        
        let options = MKMapSnapshotter.Options()
        options.size = CGSize(width: width, height: height)
        options.mapType = .satelliteFlyover
        options.camera = MKMapCamera(lookingAtCenter: coords, fromDistance: 10000, pitch: 0, heading: 0)
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            if snapshot != nil {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
                imageView.image = snapshot!.image
                snapshotView.addSubview(imageView)
            }
        }
        
        annotationView.detailCalloutAccessoryView = snapshotView
        print ("***** \(#function) *****E")
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print ("***** \(#function) *****")

        print ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        let allSubViews = view.subviewsRecursive()

        for child in allSubViews {
            print (child)

            if child.debugDescription.contains("_MKCalloutContentView") {
                print ("--------Got it")
                child.backgroundColor = .red
            }
        }

        print ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        //this sends an objc_send message that returns the view hierachy
        let recursiveViews = view.perform(Selector(("recursiveDescription")))
        print (recursiveViews as Any)

        if recursiveViews.debugDescription.contains("_MKUILabel") {
            print ("--------Got it")
        }
        print ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")

        print ("View Subviews \(view.subviews.count)")
        
        print (">>>>>>>>>>>>> Views \(view.subviews.count)")
        for v in view.subviews{

            print (">>>>>>>>>>>>> Subviews \(v.subviews.count)")
            print (">>>>>>>>>>>>> tag \(v.tag)")

            for vv in v.subviews {
                print (">>>>>>>>>>>>> Sub - tag \(vv.tag)")
            }

            if v.subviews.count > 0 {
                v.subviews[0].backgroundColor = UIColor.red
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print ("***** \(#function) *****")
        
        
        let city = annotationView.annotation?.subtitle!!
        let result_city = city?.replacingOccurrences(of: " ", with: "_", options: NSString.CompareOptions.literal, range:nil)
        
        let country = annotationView.annotation?.subtitle!!
        let result_country = country?.replacingOccurrences(of: " ", with: "_", options: NSString.CompareOptions.literal, range:nil)
        
        var strURL = "https://en.wikipedia.org/wiki/" + result_city!
        
        var url_to_use : URL!
        
        print ("Try 1 : \(strURL)")
        if let url = URL(string: strURL) {
            url_to_use = url
        } else {
            strURL = "https://en.wikipedia.org/wiki/" + result_city! + ",_" + result_country!
            //https://en.wikipedia.org/wiki/San_José,_Costa_Rica
            //"https://en.wikipedia.org/wiki/San_José,Costa_Rica"
            
            
            print ("Try 2 : \(strURL)")
            if let url = URL(string: strURL) {
                url_to_use = url
            } else {
                
                print ("ERROR : \(String(describing: url_to_use))")
                return
            }
            
        }
        
        //configureDetailView(annotationView: annotationView)

        print (url_to_use)
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url_to_use, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:])) {_ in }
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url_to_use)
        }
        
    }
    
    
}

extension ViewController : CLLocationManagerDelegate {
    
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

extension UIView {
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
    
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UILabel{
    var defaultFont: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
