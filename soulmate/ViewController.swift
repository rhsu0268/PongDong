//
//  ViewController.swift
//  soulmate
//
//  Created by Richard Hsu on 8/2/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    
    let manager = LocationManager()
    
    //@IBOutlet weak var tableView: UITableView!
    var locationManager: CLLocationManager?
    var startLocation: CLLocation?
    
    
    
    var myGroup = dispatch_group_create()
    var coordinate: Coordinate?
    
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var newsAPIClient = {
        return NewsAPIClient(APIKey: "hello")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.getPermission()
        manager.onLocationFix = { [weak self] coordinate in
            
            print("---LocationManager---")
            print(coordinate)
            self?.coordinate = coordinate
            print("---")
            
        }
      
        
        // start network request to alchemyapi
        
        /*
        newsAPIClient.fetchCurrentNews()
        {
            result in
            switch result
            {
                case .Success(let currentNews):
                    print("---start---")
                    print(result)
                    print("---end---")
                
                case .Failure(let error as NSError):
                    self.showAlert("Unable to retrieve news", message: error.localizedDescription)
                
                default: break
                
            }
        }
         */
 
               

        /*
        let task = session.dataTaskWithURL(url!)
        {
            (data, response, error) -> Void in //in
            //guard let data = data else { print(error); return }
        
        
            //let result = NSString(data: data, encoding: NSUTF8StringEncoding)
            //print(result);
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200)
            {
                print("Request data is successful!")
                
                //var err: NSError?
                do
                {
                  
                }
                catch
                {
                    print("Error with JSON!")
                }
            }
         
            
            
            
        }
        task.resume();
         */
        
        /*
        func getJson(url:NSURL, completion: (json:NSDictionary?, error:NSError?)->()) {
            
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url) {
                (data:NSData?, response:NSURLResponse?, error:NSError?) in
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary
                    completion(json: json, error:nil)
                } catch let caught as NSError {
                    completion(json: nil, error:caught)
                } catch {
                    // Something else happened.
                    let error: NSError = NSError(domain: "<Your domain>", code: 1, userInfo: nil)
                    completion(json: nil, error:error)
                }
            }
            
            task.resume()
        }
        dispatch_group_enter(myGroup)
        getJson(url!) { (json, error) -> () in
            if error != nil {
                print(error!)
            } else {
                //print(json!)
                // do something with the json dictionary
                if let object = json!["result"]!["docs"] as? [[String : AnyObject]]
                {
                    for article in object
                    {
                        //print(article)
                        
                        // create a new NewsInformation object
                        let newsInformation = NewsInformation(title: "", url: "")
                        
                        if let title = article["source"]!["enriched"]!!["url"]!!["title"] as? String
                        {
                            //print(title)
                            newsInformation.title = title
                        }
                        //print("---")
                        if let url = article["source"]!["enriched"]!!["url"]!!["url"] as? String
                        {
                            //print(url)
                            newsInformation.url = url;
                        }
                        print(newsInformation)
                        self.newsArticles.append(newsInformation)
                        print("---")
                        
                    
                    }
                }
                dispatch_group_leave(self.myGroup)
                print(self.newsArticles)
               
            }
        }
       
        dispatch_async(dispatch_get_main_queue(), {
            
            [unowned self] in
            self.tableView.reloadData()
        })
        */
        let userLocation = UserLocation(name: "You", type: "You are here!", imageName: "yourLocation.png", latitude: 38.9075, longitude: -77.0365)
        //mapView.setRegion(region, animated: true)
        
        
        //mapView.delegate = self
        //mapView.mapType = .Standard
        //mapView.rotateEnabled = false
        //mapView.addAnnotation(userLocation)
        
        //let regionRadius: CLLocationDistance = 15000
        //let coordinateRegion = MKCoordinateRegionMakeWithDistance((userLocation.location.coordinate), regionRadius, regionRadius)
        //mapView.setRegion(coordinateRegion, animated: true)
        
        // set up the locationManager
        //locationManager = CLLocationManager()
        //locationManager?.delegate = self
        //locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager?.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showAlert(title: String, message: String?, style: UIAlertControllerStyle = .Alert)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        // create a region instance
        
        //let userLocation = UserLocation(name: "You", type: "You are here!", imageName: "yourLocation.png", latitude: 38.9075, longitude: -77.0365)
        var region = MKCoordinateRegion()
        print("---Inside mapview---")
        print(mapView.userLocation.coordinate)
        print("--- ---")
        region.center = mapView.userLocation.coordinate
        
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        
  
        //let regionRadius: CLLocationDistance = 15000
        //let coordinateRegion = MKCoordinateRegionMakeWithDistance((userLocation.location.coordinate), regionRadius, regionRadius)
        //mapView.setRegion(coordinateRegion, animated: true)
        mapView.setRegion(region, animated: true)
    }
 
    


}

/*
extension ViewController: MKMapViewDelegate
{
    func mapViewWillStartRenderingMap(mapView: MKMapView)
    {
        print("rendering")
    }
}
*/




/*
// implement the CLLocationManagerDelegate protocol 
extension ViewController: CLLocationManagerDelegate
{
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil
        {
            startLocation = locations.first
            print("---startLocation---")
            //print(startLocation)
            
            print(startLocation?.coordinate.latitude)
            print(startLocation?.coordinate.longitude)
            let userLocation = UserLocation(name: "You", type: "You are here!", imageName: "yourLocation.png", latitude: (startLocation?.coordinate.latitude)!, longitude: (startLocation?.coordinate.longitude)!)
            self.mapView.addAnnotation(userLocation)
            print("---")
        }
        else
        {
            guard let latest = locations.first else { return }
            //let distanceInMeters = startLocation?.distanceFromLocation(latest)
            //print("distance in meters: \(distanceInMeters!)")
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedWhenInUse || status == .AuthorizedAlways
        {
            //locationManager?.startUpdatingLocation()
            //locationManager?.allowsBackgroundLocationUpdates = true
            
            //locationManager?.requestLocation();
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    
    }
}


*/

