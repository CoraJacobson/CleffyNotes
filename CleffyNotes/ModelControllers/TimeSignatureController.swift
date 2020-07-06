//
//  TimeSignatureController.swift
//  CleffyNotes
//
//  Created by Cora Jacobson on 6/25/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class TimeSignatureController {
    
    var timeSignatures: [TimeSignature] = [
        TimeSignature(name: "two4", image: UIImage(named: "two4"), beats: 2, displayBeats: 2),
        TimeSignature(name: "three4", image: UIImage(named: "three4"), beats: 3, displayBeats: 3),
        TimeSignature(name: "four4", image: UIImage(named: "four4"), beats: 4, displayBeats: 4),
        TimeSignature(name: "five4", image: UIImage(named: "five4"), beats: 5, displayBeats: 5),
        TimeSignature(name: "three8", image: UIImage(named: "three8"), beats: 1, displayBeats: 3),
        TimeSignature(name: "six8", image: UIImage(named: "six8"), beats: 2, displayBeats: 6),
        TimeSignature(name: "nine8", image: UIImage(named: "nine8"), beats: 3, displayBeats: 9),
        TimeSignature(name: "twelve8", image: UIImage(named: "twelve8"), beats: 4, displayBeats: 12)
    ]
    
    func createBeatArray(_ timeSignature: TimeSignature) -> [Int] {
        var array: [Int] = []
        for beat in 1...timeSignature.displayBeats {
            array.append(beat)
        }
        switch timeSignature.name {
        case "three8":
            array.insert(1, at: 1)
        case "six8":
            array.insert(1, at: 1)
            array.insert(4, at: 5)
        case "nine8":
            array.insert(1, at: 1)
            array.insert(4, at: 5)
            array.insert(7, at: 9)
        case "twelve8":
            array.insert(1, at: 1)
            array.insert(4, at: 5)
            array.insert(7, at: 9)
            array.insert(10, at: 13)
        default:
            return array
        }
        return array
    }
    
    let tempoKey = "lastTempoUsed"
    let timeSignatureKey = "lastTimeUsed"
    
    func lastMetronomeSettings(_ tempo: Int, _ index: Int) {
        let lastTempoUsed = tempo
        UserDefaults.standard.set(lastTempoUsed, forKey: tempoKey)
        let lastTimeUsed = index
        UserDefaults.standard.set(lastTimeUsed, forKey: timeSignatureKey)
    }
    
    var lastTempoUsed: Int? {
        return UserDefaults.standard.integer(forKey: tempoKey)
    }
    
    var lastTimeUsed: Int? {
        return UserDefaults.standard.integer(forKey: timeSignatureKey)
    }
    
    init() {
        if lastTempoUsed == nil || lastTimeUsed == nil {
            lastMetronomeSettings(80, 0)
        }
    }
    
}
