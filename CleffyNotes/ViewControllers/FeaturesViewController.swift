//
//  FeaturesViewController.swift
//  CleffyNotes
//
//  Created by Cora Jacobson on 5/24/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class FeaturesViewController: UIViewController {

    let keyController = KeyController()
    let modeController = ModeController()
    let timeSignatureController = TimeSignatureController()
    let themeHelper = ThemeHelper()
    
    @IBOutlet weak var transposition: UIButton!
    @IBOutlet weak var keysAndScales: UIButton!
    @IBOutlet weak var metronome: UIButton!
    @IBOutlet weak var changeThemeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
    }
    
    @IBAction func changeThemeButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Please choose a theme:", message: nil, preferredStyle: .alert)
        let purpleButton = UIAlertAction(title: "Purple", style: .default, handler: {action in self.themeHelper.setThemePreferenceToPurple(); self.setTheme()})
        let greenButton = UIAlertAction(title: "Green", style: .default, handler: {action in self.themeHelper.setThemePreferenceToGreen(); self.setTheme()})
        let blueButton = UIAlertAction(title: "Blue", style: .default, handler: {action in self.themeHelper.setThemePreferenceToBlue(); self.setTheme()})
        alert.addAction(purpleButton)
        alert.addAction(greenButton)
        alert.addAction(blueButton)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "transpositionShowSegue":
            if let transpositionVC = segue.destination as? TranspositionViewController {
                transpositionVC.keyController = keyController
                transpositionVC.themeHelper = themeHelper
            }
        case "keysAndScalesShowSegue":
            if let keysAndScalesVC = segue.destination as? KeysAndScalesViewController {
                keysAndScalesVC.keyController = keyController
                keysAndScalesVC.modeController = modeController
                keysAndScalesVC.themeHelper = themeHelper
            }
        case "metronomeShowSegue":
            if let metronomeVC = segue.destination as? MetronomeViewController {
                metronomeVC.themeHelper = themeHelper
                metronomeVC.timeSignatureController = timeSignatureController
            }
        default:
            return
        }
    }

    func setTheme() {
        transposition.layer.cornerRadius = 8
        keysAndScales.layer.cornerRadius = 8
        metronome.layer.cornerRadius = 8
        changeThemeButton.layer.cornerRadius = 8
        if let theme = themeHelper.themePreference {
            switch theme {
            case "Green":
                view.backgroundColor = .myLightGreen
                transposition.backgroundColor = .myGreen
                keysAndScales.backgroundColor = .myGreen
                metronome.backgroundColor = .myGreen
                changeThemeButton.backgroundColor = .myGreen
                navigationController?.navigationBar.barTintColor = .myGreen
            case "Blue":
                view.backgroundColor = .myLightBlue
                transposition.backgroundColor = .myBlue
                keysAndScales.backgroundColor = .myBlue
                metronome.backgroundColor = .myBlue
                changeThemeButton.backgroundColor = .myBlue
                navigationController?.navigationBar.barTintColor = .myBlue
            default:
                view.backgroundColor = .myLightPurple
                transposition.backgroundColor = .myPurple
                keysAndScales.backgroundColor = .myPurple
                metronome.backgroundColor = .myPurple
                changeThemeButton.backgroundColor = .myPurple
                navigationController?.navigationBar.barTintColor = .myPurple
            }
        } else { return }
    }
    
}
