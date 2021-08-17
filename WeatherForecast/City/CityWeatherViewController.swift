//
//  CityWeatherViewController.swift
//  WeatherForecast
//
//  Created by dattaphani on 09/08/21.
//

import UIKit
import MapKit
private enum Section: CaseIterable {
    case Area
    
    case Today_temperature
    
    case Today_humidity
    
    case Today_rain_chances
    
    case Today_wind_information
}

class CityWeatherViewController: UIViewController {
    @IBOutlet weak var cityweatherCollectionView: UICollectionView!
    var selectedLoc:CLLocation?
    let cityvm = cityVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityweatherCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
      
        self.cityweatherCollectionView.register(TempDetailCollectionViewCell.self, forCellWithReuseIdentifier: "TempDetailCollectionViewCell")
      

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        cityvm.getcurrentCityWeather(loc: selectedLoc ?? CLLocation(latitude: 0.0, longitude: 0.0), completion: {
            _ in DispatchQueue.main.async {
                self.cityweatherCollectionView.reloadData()
                      }
        })
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
extension CityWeatherViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            switch Section.allCases[indexPath.section] {
            case .Area:
                sectionHeader.label.text = "Area Name"
                break
            case .Today_temperature :
                sectionHeader.label.text = "Today Temperature"
                break
            case .Today_humidity :
                sectionHeader.label.text = "Today Humidity"
                break
            case .Today_rain_chances :
                sectionHeader.label.text = "Today Rain Chances"
                break
            case .Today_wind_information :
                sectionHeader.label.text = "Wind"
                break
            }
             
             return sectionHeader
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 20)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TempDetailCollectionViewCell", for: indexPath) as? TempDetailCollectionViewCell else {  return UICollectionViewCell()
        }
       
        switch Section.allCases[indexPath.section] {
        
        case .Area:
            cell.updateData(text:"\(self.cityvm.cityweather?.name ?? "")")
            break
        case .Today_temperature :
            cell.updateData(text:"\(self.cityvm.cityweather?.main?.temp ?? 0.0)")
            break
        case .Today_humidity :
            cell.updateData(text:"\(self.cityvm.cityweather?.main?.humidity ?? 0 )")
            break
        case .Today_wind_information :
            cell.updateData(text:"\(self.cityvm.cityweather?.wind?.speed ?? 0.0)")
            break
        case .Today_rain_chances:
            cell.updateData(text:"\(self.cityvm.cityweather?.weather?.first?.main ?? "")")
            break
            
        }
       
        return cell
    }
    
    
}

extension CityWeatherViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if #available(iOS 11.0, *) {
            return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - 14, height: 70)
        } else {
            return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - 14, height: 70)
        }
    }
    
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
          if UIDevice.current.orientation.isLandscape,
              let layout = cityweatherCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
              let width = view.safeAreaLayoutGuide.layoutFrame.width
              layout.itemSize = CGSize(width: width - 14, height: 50)
              layout.invalidateLayout()
          } else if UIDevice.current.orientation.isPortrait,
              let layout = cityweatherCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = view.safeAreaLayoutGuide.layoutFrame.width
              layout.itemSize = CGSize(width: width - 14, height: 50)
              layout.invalidateLayout()
          }
      }
}
