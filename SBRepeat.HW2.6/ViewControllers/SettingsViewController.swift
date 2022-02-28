//
//  SettingsViewController.swift
//  SBRepeat.HW2.6
//
//  Created by Philip Noskov on 28.02.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabelValue: UILabel!
    @IBOutlet var greenLabelValue: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redValueTF: UITextField!
    @IBOutlet var greenValueTF: UITextField!
    @IBOutlet var blueValueTF: UITextField!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    var miniViewColor: UIColor!
    var delegate: MainViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = miniViewColor
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        setupView()

    }
    
    @IBAction func sliderChangeValue(_ sender: UISlider) {
        
        setColor()
        
        switch sender {
        case redSlider:
            redLabelValue.text = string(from: redSlider)
            redValueTF.text = redLabelValue.text
        case greenSlider:
            greenLabelValue.text = string(from: greenSlider)
            greenValueTF.text = greenLabelValue.text
        default:
            blueValueLabel.text = string(from: blueSlider)
            blueValueTF.text = blueValueLabel.text
        }
    }
    
    @IBAction func saveButtonPressed() {
        delegate.setNewColor(from: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    private func setupView() {
        let ciColorFormMainView = CIColor(color: miniViewColor)
        
        redSlider.value = Float(ciColorFormMainView.red)
        greenSlider.value = Float(ciColorFormMainView.green)
        blueSlider.value = Float(ciColorFormMainView.blue)
        
        redLabelValue.text = string(from: redSlider)
        greenLabelValue.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)
        
        redValueTF.text = string(from: redSlider)
        greenValueTF.text = string(from: greenSlider)
        blueValueTF.text = string(from: blueSlider)

    }
    
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }

}

extension SettingsViewController: UITextFieldDelegate {
    
    
    
}
