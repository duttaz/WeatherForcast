//
//  WFHomeViewController+TVE.swift
//  WeatherForecast
//
//  Created by 3EMBED on 18/08/21.
//

import Foundation
import UIKit
import CoreLocation
import CoreData

extension WFHomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }

        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")   else {   return UITableViewCell() }
        // Fetch Note
        let loc = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = loc.locationTitle
        cell.detailTextLabel?.text = loc.locationDescription
        cell.selectionStyle = .none
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loc = fetchedResultsController.object(at: indexPath)
        selectedLoc = CLLocation(latitude: Double(loc.latitude ?? 0.0), longitude: Double(loc.longitude ?? 0.0))
        self.performSegue(withIdentifier: "toweather", sender: nil)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let loc = fetchedResultsController.object(at: indexPath)
            appDelegate.persistentContainer.viewContext.delete(loc)
            do {
                try appDelegate.persistentContainer.viewContext.save()
            } catch {
                fatalCoreDataError(error: error as NSError)
                return
             }
            }
    }
    
    
    
}
