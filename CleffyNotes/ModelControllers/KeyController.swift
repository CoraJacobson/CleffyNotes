//
//  KeyController.swift
//  CleffyNotes
//
//  Created by Cora Jacobson on 6/18/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class KeyController {
    
    var majorKeys: [Key] = [
    Key(name: "A", nameImage: UIImage(named: "KeyA"), keySig: "3\u{266F}", keySigImage: UIImage(named: "Key3Sharps")),
    Key(name: "A\u{266F} / B\u{266D}", nameImage: UIImage(named: "KeyASharp"), keySig: "2\u{266D}", keySigImage: UIImage(named: "Key2Flats")),
    Key(name: "B", nameImage: UIImage(named: "KeyB"), keySig: "5\u{266F} / 7\u{266D}", keySigImage: UIImage(named: "Key5Sharps")),
    Key(name: "C", nameImage: UIImage(named: "KeyCNote"), keySig: "no \u{266F} or \u{266D}", keySigImage: UIImage(named: "Key0")),
    Key(name: "C\u{266F} / D\u{266D}", nameImage: UIImage(named: "KeyCSharp"), keySig: "7\u{266F} / 5\u{266D}", keySigImage: UIImage(named: "Key7Sharps")),
    Key(name: "D", nameImage: UIImage(named: "KeyD"), keySig: "2\u{266F}", keySigImage: UIImage(named: "Key2Sharps")),
    Key(name: "D\u{266F} / E\u{266D}", nameImage: UIImage(named: "KeyDSharp"), keySig: "3\u{266D}", keySigImage: UIImage(named: "Key3Flats")),
    Key(name: "E", nameImage: UIImage(named: "KeyE"), keySig: "4\u{266F}", keySigImage: UIImage(named: "Key4Sharps")),
    Key(name: "F", nameImage: UIImage(named: "KeyF"), keySig: "1\u{266D}", keySigImage: UIImage(named: "Key1Flat")),
    Key(name: "F\u{266F} / G\u{266D}", nameImage: UIImage(named: "KeyFSharp"), keySig: "6\u{266F} / 6\u{266D}", keySigImage: UIImage(named: "Key6Sharps")),
    Key(name: "G", nameImage: UIImage(named: "KeyG"), keySig: "1\u{266F}", keySigImage: UIImage(named: "Key1Sharp")),
    Key(name: "G\u{266F} / A\u{266D}", nameImage: UIImage(named: "KeyGSharp"), keySig: "4\u{266D}", keySigImage: UIImage(named: "Key4Flats"))
    ]
    
    
    // Key Signatures are displayed out of order in the picker for visual purposes - reorderKeys provides the conversion
    
    let reorderKeys = [3,10,5,0,7,2,9,4,11,6,1,8]
    
    var reorderedKeys: [Key] {
        var result: [Key] = []
        for code in reorderKeys {
            result.append(majorKeys[code])
        }
        return result
    }
 
    
    // transposeBy = 0 or 1 - segmented control - by key signature or by instrument
    // fromKey, toKey, note = 0-11 - index of key/note selected
    // return = 0-11 - index of tranposed note
    
    func transpose(_ transposeBy: Int, _ fromKey: Int, _ toKey: Int, _ note: Int) -> String {
        var newNoteIndex = note
        var from = fromKey
        var to = toKey
        var keyChange = (from - to)
        if keyChange == 0 {
            return majorKeys[note].name
        } else {
            switch transposeBy {
            case 0:
                from = reorderKeys[fromKey]
                to = reorderKeys[toKey]
                keyChange = (from - to)
                newNoteIndex = note - keyChange
            default:
                newNoteIndex = note + keyChange
            }
            if newNoteIndex >= 12 {
                newNoteIndex = newNoteIndex - 12
            } else if newNoteIndex < 0 {
                newNoteIndex = newNoteIndex + 12
            }
            return majorKeys[newNoteIndex].name
        }
    }
    
    var notes: [Note] = [
        Note(sharpName: "A", flatName: "A", frequency: 220.00),
        Note(sharpName: "A\u{266F}", flatName: "B\u{266D}", frequency: 233.08),
        Note(sharpName: "B", flatName: "B", frequency: 246.94),
        Note(sharpName: "C", flatName: "C", frequency: 261.63),
        Note(sharpName: "C\u{266F}", flatName: "D\u{266D}", frequency: 277.18),
        Note(sharpName: "D", flatName: "D", frequency: 293.66),
        Note(sharpName: "D\u{266F}", flatName: "E\u{266D}", frequency: 311.13),
        Note(sharpName: "E", flatName: "E", frequency: 329.63),
        Note(sharpName: "F", flatName: "F", frequency: 349.23),
        Note(sharpName: "F\u{266F}", flatName: "G\u{266D}", frequency: 369.99),
        Note(sharpName: "G", flatName: "G", frequency: 392.00),
        Note(sharpName: "G\u{266F}", flatName: "A\u{266D}", frequency: 415.30),
        Note(sharpName: "A", flatName: "A", frequency: 440.00),
        Note(sharpName: "A\u{266F}", flatName: "B\u{266D}", frequency: 466.16),
        Note(sharpName: "B", flatName: "B", frequency: 493.88),
        Note(sharpName: "C", flatName: "C", frequency: 523.25),
        Note(sharpName: "C\u{266F}", flatName: "D\u{266D}", frequency: 554.37),
        Note(sharpName: "D", flatName: "D", frequency: 587.33),
        Note(sharpName: "D\u{266F}", flatName: "E\u{266D}", frequency: 622.25),
        Note(sharpName: "E", flatName: "E", frequency: 659.25),
        Note(sharpName: "F", flatName: "F", frequency: 698.46),
        Note(sharpName: "F\u{266F}", flatName: "G\u{266D}", frequency: 739.99),
        Note(sharpName: "G", flatName: "G", frequency: 783.99),
        Note(sharpName: "G\u{266F}", flatName: "A\u{266D}", frequency: 830.61)
    ]
    
}
