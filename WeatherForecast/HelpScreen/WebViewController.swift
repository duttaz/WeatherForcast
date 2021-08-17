//
//  WebViewController.swift
//  WeatherForecast
//
//  Created by 3EMBED on 18/08/21.
//

import UIKit
import WebKit


class WebViewController: UIViewController , WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    let htmlCode = "<h1 style='color:red;font-size:120px;'>Steps to use App</h1> <p style='color:blue;font-size:60px;'>STEP 1</p><p style='color:blue;font-size:40px;'>On tapping plus button user redirects to map.Where user can select location.</p> <img src='1.png'style='object-fit:scale-down;object-position: center;'><p style='color:blue;font-size:60px;'>STEP 2</p><p style='color:blue;font-size:40px;'>In Map,user can drag map and pick location.</p> <img src='2.png'style='object-fit:scale-down;object-position: center;'><p style='color:blue;font-size:60px;'>STEP 3</p><p style='color:blue;font-size:40px;'>Locations bookmarked are shown here and user can delete bookmarked locations.</p> <img src='3.png'style='object-fit:scale-down;object-position: center;'><p style='color:blue;font-size:60px;'>STEP 4</p> <p style='color:blue;font-size:40px;'>Weather screen gives update of selected location weather forecast details of current day.</p><img src='4.png'style='object-fit:scale-down;object-position: center;'>"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Help"
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        let bundle = Bundle(for: Self.self)
        let url = bundle.resourceURL
        self.webView.loadHTMLString(htmlCode, baseURL: url)
        // Do any additional setup after loading the view.
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
