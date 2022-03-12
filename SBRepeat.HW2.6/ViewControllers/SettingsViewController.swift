//
//  SettingsViewController.swift
//  SBRepeat.HW2.6
//
//  Created by Philip Noskov on 28.02.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
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
    
    // MARK: - Public Properties
    
    
    var miniViewColor: UIColor!
    var delegate: MainViewControllerDelegate!
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = miniViewColor
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        setupView()
        
        addDoneButton(textField: redValueTF)
        addDoneButton(textField: greenValueTF)
        addDoneButton(textField: blueValueTF)

    }
    
    // MARK: - IBActions
    
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
    
    // MARK: - Private Methods
    
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

// MARK: - Extensions

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if let valueFromText = Float(text){
                if valueFromText < 1 {
                    switch textField {
                    case redValueTF:
                        redSlider.value = valueFromText
                        redLabelValue.text = String(valueFromText)
                    case greenValueTF:
                        greenSlider.value = valueFromText
                        greenLabelValue.text = String(valueFromText)
                    default:
                        blueSlider.value = valueFromText
                        blueValueLabel.text = String(valueFromText)
                    }
                } else {
                    showAlert(with: "Wrong format", and: "Please, input value in range from 0 to 1!")
                    textField.text = ""
                }
            }
            setColor()
        }
    }
    
   private func addDoneButton(textField: UITextField) {
        
        let keypadToolbar: UIToolbar = UIToolbar()
        
        keypadToolbar.items=[
            UIBarButtonItem(
                barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                target: self,
                action: nil
            ),
            UIBarButtonItem(
                title: "Done",
                style: UIBarButtonItem.Style.done,
                target: textField,
                action: #selector(UITextField.resignFirstResponder)
            )
        ]
        keypadToolbar.sizeToFit()
        textField.inputAccessoryView = keypadToolbar
    }
    
    private func showAlert(with title: String, and message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
