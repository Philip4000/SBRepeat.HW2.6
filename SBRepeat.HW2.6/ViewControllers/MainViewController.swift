//
//  MainViewController.swift
//  SBRepeat.HW2.6
//
//  Created by Philip Noskov on 28.02.2022.
//

import UIKit

protocol MainViewControllerDelegate {
    func setNewColor(from color: UIColor)
}

class MainViewController: UIViewController {
    
    var mainViewColor = UIColor(red: 0.5, green: 0.3, blue: 0.2, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = mainViewColor.cgColor
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {return}
        settingsVC.miniViewColor = mainViewColor
        settingsVC.delegate = self
    }

}

extension MainViewController: MainViewControllerDelegate {
    func setNewColor(from color: UIColor) {
        mainViewColor = color
        view.layer.backgroundColor = mainViewColor.cgColor
    }
}

