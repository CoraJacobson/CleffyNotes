//
//  MetronomeViewController.swift
//  CleffyNotes
//
//  Created by Cora Jacobson on 6/25/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit
import AudioKit

class MetronomeViewController: UIViewController {
    
    var themeHelper: ThemeHelper?
    var timeSignatureController: TimeSignatureController?
    
    var tempo: Int = 80 {
        didSet {
            metronome.tempo = Double(tempo)
            metronome2.tempo = Double(tempo * 3)
            timeSignatureController?.lastMetronomeSettings(tempo, index)
        }
    }
    
    var index: Int = 0 {
        didSet {
            timeSignatureController?.lastMetronomeSettings(tempo, index)
            metronome.subdivision = timeSignatureController?.timeSignatures[index].beats ?? 2
        }
    }
    
    lazy var timeSignature: TimeSignature = timeSignatureController?.timeSignatures[index] ?? TimeSignature(name: "two4", image: UIImage(named: "two4"), beats: 2, displayBeats: 2)
        
    var beatArray: [Int] = [1,2]
    var displayBeatIndex: Int = 0

    @IBOutlet weak var beatsPerMinuteLabel: UILabel!
    @IBOutlet weak var timeSignatureLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var displayBeatLabel: UILabel!
    
    @IBOutlet weak var beatsSlider: UISlider!
    @IBOutlet weak var timeSignaturePicker: UIPickerView!
    
    lazy var metronome: AKMetronome = {
        let metronome = AKMetronome()
        metronome.subdivision = timeSignature.beats
        metronome.tempo = Double(tempo)
        metronome.frequency1 = 450
        metronome.frequency2 = 600
        metronome.callback = {
            DispatchQueue.main.async {
                switch self.timeSignature.name {
                case "three8", "six8", "nine8", "twelve8":
                    var beatArray2: [Int] = []
                    for beat in 1...self.timeSignature.beats {
                        for _ in 1...4 {
                            beatArray2.append(beat)
                        }
                    }
                    self.displayBeatLabel.text = "\(beatArray2[self.displayBeatIndex])  :  \(self.beatArray[self.displayBeatIndex])"
                    if self.displayBeatIndex < (self.beatArray.count - 1) {
                        self.displayBeatIndex += 1
                    } else {
                        self.displayBeatIndex = 0
                    }
                default:
                    self.displayBeatLabel.text = "\(self.beatArray[self.displayBeatIndex])"
                    if self.displayBeatIndex < (self.beatArray.count - 1) {
                        self.displayBeatIndex += 1
                    } else {
                        self.displayBeatIndex = 0
                    }
                }
            }
        }
        return metronome
    }()
    
    lazy var metronome2: AKMetronome = {
        let metronome2 = AKMetronome()
        metronome2.tempo = Double(tempo * 3)
        metronome2.subdivision = timeSignature.beats
        metronome2.frequency1 = 900
        return metronome2
    }()
    
    override func viewDidLoad() {
        do {
            try AudioKit.stop()
        } catch {
            print("error")
        }
        super.viewDidLoad()
        setTheme()
        timeSignaturePicker.delegate = self
        timeSignaturePicker.dataSource = self
        setMetronome()
        AudioKit.output = AKMixer(metronome, metronome2)
        do {
            try AudioKit.start()
        } catch {
            print("error")
        }
        metronome.start()
        metronome.stop()
        metronome.reset()
        metronome2.start()
        metronome2.stop()
        metronome2.reset()
    }
    
    @IBAction func beatsSlider(_ sender: UISlider) {
        tempo = Int(sender.value)
        beatsPerMinuteLabel.text = "Beats per Minute: \(tempo)"
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        if metronome.isPlaying {
            startButton.setTitle("Start", for: .normal)
            metronome.stop()
            metronome.reset()
            displayBeatIndex = 0
            if metronome2.isPlaying {
                metronome2.stop()
                metronome2.reset()
            }
        } else {
            startButton.setTitle("Stop", for: .normal)
            switch timeSignature.name {
            case "three8", "six8", "nine8", "twelve8":
                metronome.restart()
                metronome2.restart()
            default:
                metronome.restart()
            }
        }
    }
    
    func setTheme() {
        startButton.layer.cornerRadius = 8
        displayBeatLabel.layer.masksToBounds = true
        displayBeatLabel.layer.cornerRadius = 12
        displayBeatLabel.font = UIFont.monospacedDigitSystemFont(ofSize: displayBeatLabel.font.pointSize, weight: .bold)
        if let theme = themeHelper?.themePreference {
            switch theme {
            case "Green":
                view.backgroundColor = .myLightGreen
                beatsPerMinuteLabel.textColor = .myGreen
                timeSignatureLabel.textColor = .myGreen
                displayBeatLabel.textColor = .myGreen
                startButton.backgroundColor = .myGreen
                navigationController?.navigationBar.barTintColor = .myGreen
            case "Blue":
                view.backgroundColor = .myLightBlue
                beatsPerMinuteLabel.textColor = .myBlue
                timeSignatureLabel.textColor = .myBlue
                displayBeatLabel.textColor = .myBlue
                startButton.backgroundColor = .myBlue
                navigationController?.navigationBar.barTintColor = .myBlue
            default:
                view.backgroundColor = .myLightPurple
                beatsPerMinuteLabel.textColor = .myPurple
                timeSignatureLabel.textColor = .myPurple
                displayBeatLabel.textColor = .myPurple
                startButton.backgroundColor = .myPurple
                navigationController?.navigationBar.barTintColor = .myPurple
            }
        } else { return }
    }
    
    func setMetronome() {
        if let timeSignatureController = timeSignatureController {
            tempo = timeSignatureController.lastTempoUsed ?? 80
            index = timeSignatureController.lastTimeUsed ?? 0
            timeSignaturePicker.selectRow(index, inComponent: 0, animated: true)
            timeSignature = timeSignatureController.timeSignatures[index]
            beatsSlider.setValue(Float(tempo), animated: true)
            beatsPerMinuteLabel.text = "Beats per Minute: \(tempo)"
        }
    }
    
}

extension MetronomeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var imageView = UIImageView()
        guard let timeSignatureController = timeSignatureController else { return UIImageView() }
        for _ in 0..<timeSignatureController.timeSignatures.count {
            imageView = UIImageView(image: timeSignatureController.timeSignatures[row].image)
        }
        return imageView
    }
}

extension MetronomeViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeSignatureController?.timeSignatures.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let timeSignatureController = timeSignatureController {
            index = row
            timeSignature = timeSignatureController.timeSignatures[index]
            beatArray = timeSignatureController.createBeatArray(timeSignature)
        }
        displayBeatIndex = 0
        if metronome.isPlaying {
            metronome.stop()
            metronome.reset()
            metronome.restart()
            if metronome2.isPlaying {
                metronome2.stop()
                metronome2.reset()
            }
            switch timeSignature.name {
            case "three8", "six8", "nine8", "twelve8":
                metronome2.restart()
            default:
                return
            }
        }
    }
    
}
