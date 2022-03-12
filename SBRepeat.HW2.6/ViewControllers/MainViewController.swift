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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {return}
        settingsVC.miniViewColor = view.backgroundColor
        settingsVC.delegate = self
    }

}

extension MainViewController: MainViewControllerDelegate {
    func setNewColor(from color: UIColor) {
        view.backgroundColor = color
    }
}

