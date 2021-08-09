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
  
    let eggTimes = ["Soft":180,"Medium":4,"Hard":7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player : AVAudioPlayer?
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var eggLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        //This stops the timer each time it called
        timer.invalidate()
        progressBar.progress = 0
        secondsPassed = 0
        eggLabel.text = hardness
        totalTime = eggTimes[hardness]!
        //the timer itself
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
    
        
    
        //the selector function that is called everytime the timer is fired
        @objc func updateCounter(){
            if secondsPassed < totalTime {
                secondsPassed += 1
                let percentageProgress = Float(secondsPassed)/Float(totalTime)
                print(percentageProgress)
                progressBar.progress = percentageProgress
                
                
            }
            else{
                timer.invalidate()
                eggLabel.text = "DONE!"
                playSound()
            }
        }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

}
