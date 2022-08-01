//
//  ViewController.swift
//  Bullseye UIKit
//
//  Created by Ardian Pramudya Alphita on 07/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        setupSliderUI()
    }
    
    // Reset game action
    @IBAction func startOver(_ sender: UIButton) {
        startNewGame()
    }

    // Create alert with one action button
    @IBAction func showAlert(_ sender: UIButton) {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
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
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.startNewRound()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // Slider on change event
    @IBAction func sliderMoved(_ slider: UISlider) {
        
        // Round float value to int
        currentValue = lroundf(slider.value)
    }
    
    // Create new round by refresh all the value
    func startNewRound() {
        round += 1
        
        // Get random number between 1 and 100
        targetValue = Int.random(in: 1...100)
        
        // Set current value to be displayed by the slider
        currentValue = 50
        slider.value = Float(currentValue)
        
        updateLabels()
    }
    
    // Reset game
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
        setupAnimation()
    }
    
    // Update text label
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    // Customize slider
    func setupSliderUI() {
        // Thumb is the dot in the middle
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        // Insets is some kind of padding
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        // Green track
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizeable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        
        // Gray track
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    // Create animation transition using Core Animation
    func setupAnimation() {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
}

