//
//  PlankViewController.swift
//  Alarm-ios-swift
//
//  Created by Connor Stout on 8/19/19.
//  Copyright © 2019 LongGames. All rights reserved.
//

import UIKit
import Foundation
import MediaPlayer

enum states {
    case COMPLETED
    case DOING
    case NOTDONE
    case GO
}

class PlankViewController: UIViewController {
    
    @IBOutlet var goLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    
    weak var timer: Timer?
    var time: Double = 0
    var startTime: Double = 0
    var elapsed: Double = 60
    var mode = states.NOTDONE
    let minute:TimeInterval = 60.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func updateCounter() {
        
        // Calculate total time since timer started in seconds
        time = startTime - Date().timeIntervalSinceReferenceDate
        
        
        if(time<0){
            timer?.invalidate()
            startButton.isEnabled = true
            mode = states.COMPLETED
            return
        }
        // Calculate minutes
        let minutes = UInt8(time / 60.0)
        time -= (TimeInterval(minutes) * 60)
        
        // Calculate seconds
        let seconds = UInt8(time)
        time -= TimeInterval(seconds)
        
        // Calculate milliseconds
        let milliseconds = UInt8(time * 100)
        
        // Format time vars with leading zero
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strMilliseconds = String(format: "%02d", milliseconds)
        
        // Add time vars to relevant labels
        timerLabel.text = strMinutes+":"+strSeconds+":"+strMilliseconds

        
    }
    
    
    @IBAction func completedAButtonPress(_ sender: Any) {
        switch mode {
            case states.NOTDONE:
                startTime = Date().timeIntervalSinceReferenceDate + elapsed
                //endTime = Date().timeIntervalSinceReferenceDate + elapsed
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
                // Set Start/Stop button to true
                self.startButton.isEnabled = false
                self.startButton.titleLabel?.text = "COMPLETED"
            
                //please add state struct for the button to avoid this garbage
            case states.COMPLETED:
                print("YAY")
            default:
                print("nothing happened")
            
        }

        
        
    
    }
    
}
