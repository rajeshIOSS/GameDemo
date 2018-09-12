//
//  ViewController.swift
//  GameDemo
//
//  Created by Globalgyan on 12/09/18.
//  Copyright © 2018 Globalgyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var seconds = 120
    var seconds_left : Int = 0
    
    @IBOutlet weak var gameBackView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var gestureView: UIView!
    
    var directions : String!
    
    var timer = Timer()
    var isTimerRunning = false
    
    var tappedCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.barView.frame.size.width = 0
        
        //————right  swipe gestures in view————–//
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.gestureView.addGestureRecognizer(swipeRight)
        
        //———–left swipe gestures in view————–//
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(leftSwiped))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.gestureView.addGestureRecognizer(swipeLeft)
        
        //———–down swipe gestures in view————–//
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(downSwiped))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.gestureView.addGestureRecognizer(swipeDown)
        
        //———–up swipe gestures in view————–//
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(upSwiped))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.gestureView.addGestureRecognizer(swipeUp)
        
        //———–tap gestures in view————–//
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        //tap.direction = UISwipeGestureRecognizerDirection.up
        self.gestureView.addGestureRecognizer(tap)
        self.gestureView.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func viewTapped() {
        if tappedCount == 0 {
            seconds = 0
            //isTimerRunning = true
            tappedCount = 1
        }else {
            seconds = seconds_left
            //isTimerRunning = false
            tappedCount = 0
            runTimer()
        }
    }
    
    @objc func rightSwiped() {
        
        directions = "R"
        
        print("right swiped")
        if isTimerRunning == false {
            runTimer()
            //self.startButton.isEnabled = false
        }
    }
    
    @objc func leftSwiped() {
        
        directions = "L"
        
        print("left swiped")
        if isTimerRunning == false {
            runTimer()
            //self.startButton.isEnabled = false
        }
    }
    
    @objc func downSwiped() {
        
        directions = "D"
        
        print("down swiped")
        if isTimerRunning == false {
            runTimer()
            //self.startButton.isEnabled = false
        }
    }
    
    @objc func upSwiped() {
        
        directions = "U"
        
        print("Up swiped")
        if isTimerRunning == false {
            runTimer()
            //self.startButton.isEnabled = false
        }
    }

    
    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        //pauseButton.isEnabled = true
    }
    
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate time's up.
        } else {
            seconds -= 1
            seconds_left = seconds
            print(seconds)
            
            if directions! == "R" {
                if self.barView.frame.size.width < self.gameBackView.frame.size.width - 40 {
                    self.barView.frame.size.width = self.barView.frame.size.width + 20
                }
            }else if directions! == "L" {
                if self.barView.frame.size.width > 0 {
                    self.barView.frame.size.width = self.barView.frame.size.width - 20
                }
            }else if directions! == "U" {
                if self.barView.frame.origin.y > 20 {
                    self.barView.frame.origin.y = self.barView.frame.origin.y - 20
                }
            }else if directions! == "D" {
                if self.barView.frame.origin.y < self.gameBackView.frame.size.height - 40 {
                    self.barView.frame.origin.y = self.barView.frame.origin.y + 20
                }
            }
            
            //timerLabel.text = timeString(time: TimeInterval(seconds))
            //timerLabel.text = String(seconds)
            //            labelButton.setTitle(timeString(time: TimeInterval(seconds)), for: UIControlState.normal)
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    

}

