//
//  WFHomeViewController.swift
//  WeatherForecast
//
//  Created by dattaphani on 06/08/21.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class WFHomeViewController: UIViewController {
    var date = NSDate()
    var fetchedResultsController: NSFetchedResultsController<Location>!
    let appDelegate = UIApplication.shared.delegate
        as! AppDelegate
    var selectedLoc:CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    @IBOutlet var LocationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLocation()
    }
    // function to fetch locations in coredata

    func fetchLocation()
    {
        if fetchedResultsController == nil {
            let request: NSFetchRequest<Location> = Location.fetchRequest()
            
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }
        do {
            try fetchedResultsController.performFetch()
            LocationsTableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
    
    func fatalCoreDataError(error: NSError) {
        print("*** Fatal error: \(error)")
        
    }
    // Action to add new location to coredata

    func addLocationAction(_ title:String, _ desc:String, _ loc:CLLocation) {
        let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: appDelegate.persistentContainer.viewContext) as! Location
        
        location.locationDescription = title
        location.locationTitle = desc
        location.latitude = NSNumber(value: loc.coordinate.latitude)
        location.longitude = NSNumber(value: loc.coordinate.longitude)
        location.date = Date()
        
        do {
            try appDelegate.persistentContainer.viewContext.save()
        } catch {
            fatalCoreDataError(error: error as NSError)
            return
        }
        
    }
    @IBAction func HelpButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toHelp", sender: nil)
    }
    // Action to add new location
    @IBAction func AddcityButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        MapViewController.onpickingLocation = {
            (title,desc,loc) in
            
            self.addLocationAction( title, desc, loc)
        }
        self.present(MapViewController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toweather"
        {
            let controller = segue.destination as? CityWeatherViewController
            controller?.selectedLoc = selectedLoc
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
 

 

