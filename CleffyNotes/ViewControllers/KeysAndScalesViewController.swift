//
//  KeysAndScalesViewController.swift
//  CleffyNotes
//
//  Created by Cora Jacobson on 5/24/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class KeysAndScalesViewController: UIViewController {

    var keyController: KeyController?
    var modeController: ModeController?
    var themeHelper: ThemeHelper?
    
    @IBOutlet weak var keyAndModePickerView: UIPickerView!
    
    @IBOutlet weak var scaleImageView: UIImageView!
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var patternLabel: UILabel!
    @IBOutlet weak var showInLabel: UILabel!
    
    @IBOutlet weak var iLabel: UILabel!
    @IBOutlet weak var iiLabel: UILabel!
    @IBOutlet weak var iiiLabel: UILabel!
    @IBOutlet weak var ivLabel: UILabel!
    @IBOutlet weak var vLabel: UILabel!
    @IBOutlet weak var viLabel: UILabel!
    @IBOutlet weak var viiLabel: UILabel!
    
    @IBOutlet weak var flatSharpSegmentedControl: UISegmentedControl!
    
    var scale: [Note]? = [Note(sharpName: "A", flatName: "A", frequency: 220.00),
                         Note(sharpName: "B", flatName: "B", frequency: 246.94),
                         Note(sharpName: "C\u{266F}", flatName: "D\u{266D}", frequency: 277.18),
                         Note(sharpName: "D", flatName: "D", frequency: 293.66),
                         Note(sharpName: "E", flatName: "E", frequency: 329.63),
                         Note(sharpName: "F\u{266F}", flatName: "G\u{266D}", frequency: 369.99),
                         Note(sharpName: "G\u{266F}", flatName: "A\u{266D}", frequency: 415.30),
                         Note(sharpName: "A", flatName: "A", frequency: 440.00)]
    
    var flatSharpSetting: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        updateScale()
        keyAndModePickerView.delegate = self
        keyAndModePickerView.dataSource = self
    }
    
    func setTheme() {
        iLabel.layer.masksToBounds = true
        iiLabel.layer.masksToBounds = true
        iiiLabel.layer.masksToBounds = true
        ivLabel.layer.masksToBounds = true
        vLabel.layer.masksToBounds = true
        viLabel.layer.masksToBounds = true
        viiLabel.layer.masksToBounds = true
        iLabel.layer.cornerRadius = 8
        iiLabel.layer.cornerRadius = 8
        iiiLabel.layer.cornerRadius = 8
        ivLabel.layer.cornerRadius = 8
        vLabel.layer.cornerRadius = 8
        viLabel.layer.cornerRadius = 8
        viiLabel.layer.cornerRadius = 8
        if let theme = themeHelper?.themePreference {
            switch theme {
            case "Green":
                view.backgroundColor = .myLightGreen
                keyLabel.textColor = .myGreen
                modeLabel.textColor = .myGreen
                noteLabel.textColor = .myGreen
                patternLabel.textColor = .myGreen
                showInLabel.textColor = .myGreen
                navigationController?.navigationBar.barTintColor = .myGreen
            case "Blue":
                view.backgroundColor = .myLightBlue
                keyLabel.textColor = .myBlue
                modeLabel.textColor = .myBlue
                noteLabel.textColor = .myBlue
                patternLabel.textColor = .myBlue
                showInLabel.textColor = .myBlue
                navigationController?.navigationBar.barTintColor = .myBlue
            default:
                view.backgroundColor = .myLightPurple
                keyLabel.textColor = .myPurple
                modeLabel.textColor = .myPurple
                noteLabel.textColor = .myPurple
                patternLabel.textColor = .myPurple
                showInLabel.textColor = .myPurple
                navigationController?.navigationBar.barTintColor = .myPurple
            }
        } else { return }
    }
    
    func updateScale() {
        if let scale = scale {
            switch flatSharpSetting {
            case 0:
                iLabel.text = scale[0].flatName
                iiLabel.text = scale[1].flatName
                iiiLabel.text = scale[2].flatName
                ivLabel.text = scale[3].flatName
                vLabel.text = scale[4].flatName
                viLabel.text = scale[5].flatName
                viiLabel.text = scale[6].flatName
            default:
                iLabel.text = scale[0].sharpName
                iiLabel.text = scale[1].sharpName
                iiiLabel.text = scale[2].sharpName
                ivLabel.text = scale[3].sharpName
                vLabel.text = scale[4].sharpName
                viLabel.text = scale[5].sharpName
                viiLabel.text = scale[6].sharpName
            }
        }
    }
    
    @IBAction func flatSharpSegmentedControl(_ sender: UISegmentedControl) {
        flatSharpSetting = flatSharpSegmentedControl.selectedSegmentIndex
        updateScale()
    }
}

extension KeysAndScalesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 12
        default:
            return 7
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return keyController?.majorKeys[row].name
        default:
            return modeController?.modes[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        scaleImageView.image = modeController?.chooseImage(keyAndModePickerView.selectedRow(inComponent: 0), keyAndModePickerView.selectedRow(inComponent: 1))
        self.scale = modeController?.createScale(keyAndModePickerView.selectedRow(inComponent: 0), keyAndModePickerView.selectedRow(inComponent: 1))
        updateScale()
    }
    
}
