//
//  NewsViewController.swift
//  Lab7
//
//  Created by Tommy Mesquita on 4/1/22.
//  Copyright © 2022 ASU. All rights reserved.
//

import UIKit
import WebKit


class NewsViewController: UIViewController {
    
    var datetime: String?
    var depth: Double?
    var src: String?
    var eqid: String?
    var magnitude: Double?
    
    @IBOutlet weak var dateField: UILabel?
    @IBOutlet weak var depthField: UILabel?
    @IBOutlet weak var srcField: UILabel?
    @IBOutlet weak var eqidField: UILabel?
    @IBOutlet weak var magnitudeField: UILabel?
    
    override func viewDidLoad() {
        dateField?.text = "Date: \(datetime!) "
        depthField?.text = "Depth \(depth!)"
        srcField?.text = "Source: \(src!)"
        eqidField?.text = "Earthquake ID: \(eqid!)"
        magnitudeField?.text = "Magnitude \(magnitude!)"
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forward(_ sender: UIBarButtonItem) {
        
//        webView?.goForward();
    }
    
    
    @IBAction func back(_ sender: UIBarButtonItem) {
//        webView?.goBack()
        
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
