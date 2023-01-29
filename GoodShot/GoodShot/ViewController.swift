//
//  ViewController.swift
//  GoodShot
//
//  Created by Murad Ismayilov on 25.01.23.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables
    var currentSliderValue = 0
    var target = 0
    var score = 0
    var round = 0
    
    // Outlets
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setThumbImage()
        
        setTrackImage()
        
        newGame()
    }
    
    func setThumbImage() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
    }
    
    func setTrackImage() {
        let insets = UIEdgeInsets(
            top: 0,
            left: 14,
            bottom: 0,
            right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
            withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
            withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    @IBAction func newGame() {
        score = 0
        round = 0
        newRound()
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    @IBAction func takeAShot(_ sender: Any) {
        let difference = abs(target - currentSliderValue)
        var points = 100 - difference
        
        var title = ""
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {_ in self.newRound()})
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func newRound() {
        round += 1
        target = Int.random(in: 1...100)
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
        
        updateLabels()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        currentSliderValue = lroundf(sender.value)
    }
    
    func updateLabels() {
        targetLabel.text = "Shoot the \(target) down!"
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
}
