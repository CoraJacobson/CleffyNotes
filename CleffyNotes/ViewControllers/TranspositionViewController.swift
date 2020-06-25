//
//  TranspositionViewController.swift
//  CleffyNotes
//
//  Created by Cora Jacobson on 5/24/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class TranspositionViewController: UIViewController {
    
    var keyController: KeyController?
    var themeHelper: ThemeHelper?
    
    @IBOutlet weak var transposeByKeyOrInstrument: UISegmentedControl!
    
    @IBOutlet weak var transpositionExample: UITextView!
    
    @IBOutlet weak var transposeByLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var noteToTransposeLabel: UILabel!
    @IBOutlet weak var transposedNoteLabel: UILabel!
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch transposeByKeyOrInstrument.selectedSegmentIndex {
        case 1:
            transpositionExample.text = "Example: Transpose music written for alto saxophone (key of E\u{266D}) to tenor saxophone (key of B\u{266D})"
        default:
            transpositionExample.text = "Example: Transpose music written in the key of F Major (one flat) to the key of G Major (one sharp)"
        }
        keyPicker.reloadAllComponents()
        keyPicker.selectRow(0, inComponent: 0, animated: true)
        keyPicker.selectRow(0, inComponent: 1, animated: true)
        notePicker.selectRow(0, inComponent: 0, animated: true)
        result.text = "A"
    }
    
    @IBOutlet weak var keyPicker: UIPickerView!
    
    @IBOutlet weak var notePicker: UIPickerView!
    
    @IBOutlet weak var result: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        keyPicker.delegate = self
        keyPicker.dataSource = self
        notePicker.delegate = self
        notePicker.dataSource = self
    }
    
    func setTheme() {
        result.layer.cornerRadius = 12
        transpositionExample.layer.cornerRadius = 12
        if let theme = themeHelper?.themePreference {
            switch theme {
            case "Green":
                view.backgroundColor = .myLightGreen
                transposeByLabel.textColor = .myGreen
                fromLabel.textColor = .myGreen
                toLabel.textColor = .myGreen
                noteToTransposeLabel.textColor = .myGreen
                transposedNoteLabel.textColor = .myGreen
                transpositionExample.textColor = .myGreen
                navigationController?.navigationBar.barTintColor = .myGreen
            case "Blue":
                view.backgroundColor = .myLightBlue
                transposeByLabel.textColor = .myBlue
                fromLabel.textColor = .myBlue
                toLabel.textColor = .myBlue
                noteToTransposeLabel.textColor = .myBlue
                transposedNoteLabel.textColor = .myBlue
                transpositionExample.textColor = .myBlue
                navigationController?.navigationBar.barTintColor = .myBlue
            default:
                view.backgroundColor = .myLightPurple
                transposeByLabel.textColor = .myPurple
                fromLabel.textColor = .myPurple
                toLabel.textColor = .myPurple
                noteToTransposeLabel.textColor = .myPurple
                transposedNoteLabel.textColor = .myPurple
                transpositionExample.textColor = .myPurple
                navigationController?.navigationBar.barTintColor = .myPurple
            }
        } else { return }
    }
    
}

extension TranspositionViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var imageView = UIImageView()
        guard let keyController = keyController else { return UIImageView() }
        if transposeByKeyOrInstrument.selectedSegmentIndex == 0,
            pickerView == keyPicker {
            for _ in 0..<keyController.reorderedKeys.count {
                imageView = UIImageView(image: keyController.reorderedKeys[row].keySigImage)
            }
            return imageView
        } else {
            for _ in 0..<keyController.majorKeys.count {
                imageView = UIImageView(image: keyController.majorKeys[row].nameImage)
            }
            return imageView
        }
    }
}

extension TranspositionViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let keyController = keyController {
            return keyController.majorKeys.count
        } else { return 0 }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        result.text = keyController?.transpose(transposeByKeyOrInstrument.selectedSegmentIndex, keyPicker.selectedRow(inComponent: 0), keyPicker.selectedRow(inComponent: 1), notePicker.selectedRow(inComponent: 0))
    }
    
}
