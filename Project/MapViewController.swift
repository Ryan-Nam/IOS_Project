//
//  MapViewController.swift
//  Project
//
//  Created by NAM HYUNWOO on 21/10/20.
//  Copyright © 2020 NAM HYUNWOO. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
     var mapDistance : Double = 10000

    @IBOutlet weak var mapView: MKMapView!
    
    var geoCod: CLGeocoder = CLGeocoder()
    var lat : Double!
    var long : Double!
    var location : String!
    var test : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true

        print("location asdlkjaslkdjlaksjdl \(String(describing: location))")
        geoCod.geocodeAddressString(location) {
            placemarks, error in
            let placemark = placemarks?.first
            self.lat = placemark?.location?.coordinate.latitude
            self.long = placemark?.location?.coordinate.longitude
            self.test = placemark?.location
            print("TTTEEE Lat: \(String(describing: self.lat)), Lon: \(String(describing: self.long))")
            print("CLLocation Object in Func:\(String(describing: self.test))")

            let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
        }
        print("CLLocation Object out Func:\(String(describing: self.test))")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // When tool button "Type" touchs, change to satellite map
    @IBAction func changeMapType(_ sender: Any) {
        if mapView.mapType == MKMapType.standard {
            mapView.mapType = MKMapType.satellite
        }else{
            mapView.mapType = MKMapType.standard
        }
    }
    
    @IBAction func goToSydney(_ sender: Any) {
        let sydneyCenter = CLLocation(latitude: -33.8688, longitude: 151.2093)
        let region = MKCoordinateRegion(
          center: sydneyCenter.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: mapDistance)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
