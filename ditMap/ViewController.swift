//
//  ViewController.swift
//  ditMap
//
//  Created by D7703_22 on 2017. 8. 31..
//  Copyright © 2017년 D7703_22. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var myMapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 우리학교 위치정보 35.166189, 129.072594
        let center = CLLocationCoordinate2DMake(35.166189, 129.072594)
        let park = CLLocationCoordinate2DMake(35.168415, 129.057834)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(center, span)
        
        myMapView.setRegion(region, animated: true)
        
        //pin 꼽기
        let anno01 = MKPointAnnotation()
        anno01.coordinate = center
        anno01.title = "DIT동의과학대학교"
        anno01.subtitle = "나의 꿈이 자라는 곳"
        
        myMapView.addAnnotation(anno01)
        
        let anno02 = MKPointAnnotation()
        anno02.coordinate = park
        anno02.title = "부산시민공원"
        
        myMapView.addAnnotation(anno02)
        
        myMapView.delegate = self
    }
    
    //MKMapViewDelegate method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        var  annotationView = myMapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
            
            if annotation.title! == "부산시민공원" {
                annotationView?.pinTintColor = UIColor.green
                leftIconView.image = UIImage(named:"부산시민공원.png" )
                annotationView?.leftCalloutAccessoryView = leftIconView

            }
            if annotation.title! == "DIT동의과학대학교" {
                leftIconView.image = UIImage(named:"dit.jpg" )
                annotationView?.leftCalloutAccessoryView = leftIconView
                
            }
            
            
        } else {
            annotationView?.annotation = annotation
        }
        
        
        let btn = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = btn
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        print("callout Accessory Tapped!")
        
        let viewAnno = view.annotation
        let viewTitle: String = ((viewAnno?.title)!)!
        let viewSubTitle: String = ((viewAnno?.subtitle)!)!
        
        print("\(viewTitle) \(viewSubTitle)")
        
        let ac = UIAlertController(title: viewTitle, message: viewSubTitle, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

