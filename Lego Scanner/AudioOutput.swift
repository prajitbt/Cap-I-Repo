//
//  AudioOutput.swift
//  LegoScanner
//
//  
//

import Foundation
import AVFoundation


class AudioOutput{
    let synth = AVSpeechSynthesizer()
    
    func speakThePrediction(stringToSpeak: String) {
       let utt = AVSpeechUtterance(string: stringToSpeak)
       utt.voice = AVSpeechSynthesisVoice(language: "en-US")
       utt.rate = 0.3
       synth.speak(utt)
   }
}
