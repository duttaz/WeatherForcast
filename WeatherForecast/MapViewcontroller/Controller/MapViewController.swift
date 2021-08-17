//
//  MapViewController.swift
//  WeatherForecast
//
//  Created by dattaphani on 06/08/21.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}


class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var selectedPin:MKPlacemark? = nil

    @IBOutlet var locationAddressLabel: UILabel!
    var onpickingLocation:((String,String,CLLocation)-> Void)?

    var resultSearchController:UISearchController? = nil
    var pickedlocValue:CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    let locationManager = CLLocationManager()
    var selectlocationTitle = ""
    var selectedlocationdescription = ""

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()

            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }

            mapView.delegate = self
            mapView.mapType = .standard
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true

            if let coor = mapView.userLocation.location?.coordinate{
                mapView.setCenter(coor, animated: true)
            }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let locationSearchTable = storyboard.instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable )
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
      //  navigationItem.searchController = searchController

        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true

        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtontapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func pinhereButtonTapped(_ sender: Any) {
        
        onpickingLocation?(selectlocationTitle,selectedlocationdescription,pickedlocValue)
        self.dismiss(animated: true, completion: nil)
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

extension MapViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
           let state = placemark.administrativeArea {
            annotation.subtitle = "\(city)" + " " + "\(state)"
        }
        mapView.addAnnotation(annotation)
        //  let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let coordinate = CLLocationCoordinate2D(latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude)
        let region = self.mapView.regionThatFits(MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200))
        self.mapView.setRegion(region, animated: true)
        mapView.setRegion(region, animated: true)
    }
}
