//
//  ViewController.swift
//  Lab7
//
//  Created by Tommy Mesquita on 4/1/22.
//  Copyright © 2022 ASU. All rights reserved.
//
import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newsTable: UITableView!
    
    var newURL: String?
    
    var cityName:String?
    
    struct news: Decodable {
        let earthquakes: [earthquakeInfo]
    }
    
    struct earthquakeInfo: Decodable {
        let datetime: String?
        let depth: Double?
        let lng: Double?
        let src: String?
        let eqid: String?
        let magnitude: Double?
        let lat: Double?
    }
    
    // data structure that store news objects from google news
    var eqItems:[earthquakeInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of rows based on the coredata storage
        if let count = eqItems?.count
        {
            return count
        }else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // add each row from  news items array
        
        let cell = newsTable.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
        cell.layer.borderWidth = 1.0
        let news = eqItems?[indexPath.row]
        cell.textLabel?.text = news?.datetime!
        
        cell.detailTextLabel?.text = ""
        
        //        if let author = news?.author
        //        {
        //           cell.detailTextLabel?.text = news?.author!
        //        }else
        //        {
        //            cell.detailTextLabel?.text = "no author"
        //        }
        
        return cell
    }
    
    // delete table entry
    // this method makes each row editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    // return the table view style as deletable
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == .delete
        {
            
            
            self.eqItems?.remove(at: indexPath.row)
            print("item deleted")
            self.newsTable.reloadData()
        }
        
    }
    
    
    
    
    @IBAction func loadNews(_ sender: UIBarButtonItem) {
        
        DispatchQueue.main.async(execute: {
            self.getNews()
        })
        
    }
    
    func getNews() {
        
        // you need ot register @ https://newsapi.org/ and get the API KEY, then put your API KEY in the url below
        
        
        let urlAsString = newURL!
        
        print( urlAsString)
        
        let url = URL(string: urlAsString)!
        
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            let decoder = JSONDecoder()
            let jsonResult = try! decoder.decode(news.self, from: data!)
            
            //var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
            print(jsonResult)
            
            self.eqItems = jsonResult.earthquakes
            
            print(self.eqItems);
            print(self.eqItems?.count);
            
            for i in 0...(self.eqItems?.count)!-1
            {
                let y = self.eqItems?[i]
                print(y?.datetime!)
            }
            
            DispatchQueue.main.async(execute: {
                self.newsTable.reloadData()
            })
        })
        
        jsonQuery.resume()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.newsTable.indexPath(for: sender as! UITableViewCell)!
        
        let news = eqItems?[selectedIndex.row]
        
        if let detailviewController: NewsViewController = segue.destination as? NewsViewController {
            
            detailviewController.datetime = news?.datetime
            
            detailviewController.depth = news?.depth
            detailviewController.src = news?.src
            detailviewController.eqid = news?.eqid
            detailviewController.magnitude = news?.magnitude
        }
        
        
        //        if(segue.identifier == "detailNews"){
        //            if let detailviewController: NewsViewController = segue.destination as? NewsViewController {
        //
        //                detailviewController.url = news?.url
        //            }
        //        }
    }
    
    
    
    
}

