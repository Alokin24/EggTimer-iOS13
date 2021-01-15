//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = [
        "Soft": 3,
        "Medium": 4,
        "Hard": 7
    ]
    
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    var progressPercentage: Float = 0
    
    @IBOutlet weak var eggsLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        resetUI()
        
        let hardness = sender.currentTitle!
        
//        print(eggTimes[hardness]!)
        
        
        
        
        if let secondsToBoilEgg = eggTimes[hardness] {
            progressPercentage = 1.0 / Float(secondsToBoilEgg)
            countdownTimer(secondsToCount: secondsToBoilEgg)
        }
        
    }
    
    // returns the text of the labe, the progress bar progress and etc. to default values as shown in Main.storyboard
    func resetUI() {
        progressBar.progress = 0
        eggsLabel.text = "How do you like your eggs?"
    }
    
    func changeEggsLabelText() {
        eggsLabel.text = "Done."
    }
    
    func countdownTimer(secondsToCount: Int) {
        
        var secondsPassed = 0
        
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if secondsPassed < secondsToCount {
                secondsPassed += 1
                self.progressBar.progress += self.progressPercentage
                print("\(secondsPassed) seconds passed.")
            } else {
                timer.invalidate()
                self.changeEggsLabelText()
                self.playSound()
            }
        }
        
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    

}
