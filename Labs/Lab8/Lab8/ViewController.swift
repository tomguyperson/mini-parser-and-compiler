//
//  ViewController.swift
//  movingImage
//
//  Created by user on 7/8/16.
//  Copyright © 2016 ASU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer : Timer?
    var counter = 10
    
    @IBOutlet weak var timerVal: UILabel!
    @IBOutlet weak var winLoseLabel: UILabel!
    
    @IBOutlet weak var bananaImage1: UIImageView!
    @IBOutlet weak var bananaImage2: UIImageView!
    @IBOutlet weak var bananaImage3: UIImageView!
    @IBOutlet weak var bananaImage4: UIImageView!
    
    var bananaArray: [UIImageView] = []
    
    @IBOutlet weak var monkey: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winLoseLabel.isHidden = true
        timerVal.text = "Time remaining: 10"
        
        self.monkey.image = UIImage(named: "appleMonkey.jpeg")
        
       self.bananaImage1.image = UIImage(named: "banana.jpg")
        self.bananaImage2.image = UIImage(named: "banana.jpg")
        self.bananaImage3.image = UIImage(named: "banana.jpg")
        self.bananaImage4.image = UIImage(named: "banana.jpg")
        
        bananaArray.append(bananaImage1)
        bananaArray.append(bananaImage2)
        bananaArray.append(bananaImage3)
        bananaArray.append(bananaImage4)
        
        startTimer()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func stopTimer()
    {
        timer?.invalidate()
        
        var allFound = true
        
        for i in 0...3
        {
            if self.bananaArray[i].isHidden != true
            {
                allFound = false
            }
        }
        
        if allFound
        {
            winLoseLabel.isHidden = false
            winLoseLabel.text = "You won! Go back to main menu to play again"
        }
        else
        {
            winLoseLabel.isHidden = false
            winLoseLabel.text = "You lost! Go back to main menu to try again"
        }
        
        
    }
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)
    }
    
    @objc func count()
    {
        counter = counter - 1
//        let hours = Int(counter) / 3600
//        let minutes = Int(counter) / 60 % 60
        let seconds = Int(counter) % 60
        timerVal.text = "Time remaining: " + String(seconds)
        
        if (counter == 0)
        {
            stopTimer()
        }
    }
    
    @IBAction func up(_ sender: UIButton) {
        var frame  = self.monkey.frame
        frame.origin.y -= 20
        self.monkey.frame =  frame
        
        for i in 0...3
        {
            if(viewIntersectsView(monkey, second_View: bananaArray[i]))
            {
                self.bananaArray[i].isHidden = true
            }
        }
    }
    
    @IBAction func left(_ sender: UIButton) {
        var frame  = self.monkey.frame
        frame.origin.x -= 20
        self.monkey.frame =  frame
        
        for i in 0...3
        {
            if(viewIntersectsView(monkey, second_View: bananaArray[i]))
            {
                self.bananaArray[i].isHidden = true
            }
        }
    }

    @IBAction func right(_ sender: UIButton) {
        var frame  = self.monkey.frame
        frame.origin.x += 20
        self.monkey.frame =  frame
        
        for i in 0...3
        {
            if(viewIntersectsView(monkey, second_View: bananaArray[i]))
            {
                self.bananaArray[i].isHidden = true
            }
        }
    }
    
    @IBAction func down(_ sender: UIButton) {
        
        var frame  = self.monkey.frame
        frame.origin.y += 20
        self.monkey.frame =  frame
        
        for i in 0...3
        {
            if(viewIntersectsView(monkey, second_View: bananaArray[i]))
            {
                self.bananaArray[i].isHidden = true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewIntersectsView(_ first_View: UIView, second_View:UIView) -> Bool
    {
        return first_View.frame.intersects(second_View.frame)
   }

}
