//
//  WFHomeViewController+FRCE.swift
//  WeatherForecast
//
//  Created by 3EMBED on 18/08/21.
//

import Foundation
import CoreLocation
import CoreData



extension WFHomeViewController  : NSFetchedResultsControllerDelegate{
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    
    LocationsTableView.beginUpdates()
  }
  
  /*This delegate method will be called second. This method will give information about what operation exactly started taking place a insert, a update, a delete or a move. The enum NSFetchedResultsChangeType will provide the change types.
   
   
   public enum NSFetchedResultsChangeType : UInt {
   
   case insert
   
   case delete
   
   case move
   
   case update
   }
   
   */
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
    switch (type) {
    case .insert:
      if let indexPath = newIndexPath {
        LocationsTableView.insertRows(at: [indexPath], with: .fade)
      }
      break;
    case .delete:
      if let indexPath = indexPath {
        LocationsTableView.deleteRows(at: [indexPath], with: .fade)
      }
      break;
    
    case .move:
      if let indexPath = indexPath {
        LocationsTableView.deleteRows(at: [indexPath], with: .fade)
      }
      
      if let newIndexPath = newIndexPath {
        LocationsTableView.insertRows(at: [newIndexPath], with: .fade)
      }
      break;
      
    case .update:
        break;
 
    @unknown default:
        break
    }
}
  
  /*The last delegate call*/
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    /*finally balance beginUpdates with endupdates*/
    LocationsTableView.endUpdates()
  }
}
