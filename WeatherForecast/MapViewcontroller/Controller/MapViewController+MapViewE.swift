//
//  MapViewController+MapViewE.swift
//  WeatherForecast
//
//  Created by 3EMBED on 18/08/21.
//

import Foundation
import CoreLocation
import MapKit


extension MapViewController:CLLocationManagerDelegate,MKMapViewDelegate
{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        mapView.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "current location"
        annotation.subtitle = ""
        mapView.addAnnotation(annotation)

        //centerMap(locValue)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let locValue = mapView.centerCoordinate
//        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegion(center: locValue, span: span)
//        mapView.setRegion(region, animated: true)
        mapView.removeAnnotations(mapView.annotations)

        pickedlocValue = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        let ceo: CLGeocoder = CLGeocoder()

        ceo.reverseGeocodeLocation(pickedlocValue, completionHandler: {
            (placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks
            let annotation = MKPointAnnotation()
            annotation.coordinate = locValue
            annotation.title = ""
            if pm?.count ?? 0 > 0 {
                let pm = placemarks![0]
                
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                self.selectlocationTitle = ""
                self.selectlocationTitle = addressString
                self.selectlocationTitle = String(self.selectlocationTitle.dropLast(2))
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                annotation.subtitle = "\(addressString)"
                self.selectedlocationdescription = ""
                self.selectedlocationdescription = addressString
                print(addressString)
            }
            self.locationAddressLabel.text =  self.selectedlocationdescription
            mapView.addAnnotation(annotation)
        })
        
       
      }
}
