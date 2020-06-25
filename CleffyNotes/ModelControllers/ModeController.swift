//
//  ModeController.swift
//  CleffyNotes
//
//  Created by Cora Jacobson on 6/22/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class ModeController {
    
    let keyController = KeyController()
    
    var modes: [Mode] = [Mode(name: "Ionian", scaleImage: UIImage(named: "Ionian"), description:      [0,2,4,5,7,9,11,12]),
                         Mode(name: "Dorian", scaleImage: UIImage(named: "Dorian"), description: [0,2,3,5,7,9,10,12]),
                         Mode(name: "Phrygian", scaleImage: UIImage(named: "Phrygian"), description: [0,1,3,5,7,8,10,12]),
                         Mode(name: "Lydian", scaleImage: UIImage(named: "Lydian"), description: [0,2,4,6,7,9,11,12]),
                         Mode(name: "Mixolydian", scaleImage: UIImage(named: "Mixolydian"), description: [0,2,4,5,7,9,10,12]),
                         Mode(name: "Aeolian", scaleImage: UIImage(named: "Aeolian"), description: [0,2,3,5,7,8,10,12]),
                         Mode(name: "Locrian", scaleImage: UIImage(named: "Locrian"), description: [0,1,3,5,6,8,10,12])]
    
    func createScale(_ key: Int, _ mode: Int) -> [Note] {
        var scale: [Note] = []
        let scaleDescription: [Int] = modes[mode].description
        for note in scaleDescription {
            let keyedNote = note + key
            scale.append(keyController.notes[keyedNote])
        }
        return scale
    }
    
}
