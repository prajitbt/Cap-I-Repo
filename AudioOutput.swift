//
//  AudioOutput.swift
//  LegoScanner
//

import Foundation
import AVFoundation


class AudioOutput{
    let synth = AVSpeechSynthesizer()
    var audioPlayer = AVAudioPlayer()
    func speakThePrediction(stringToSpeak: String) {
       let utt = AVSpeechUtterance(string: stringToSpeak)
       utt.voice = AVSpeechSynthesisVoice(language: "en-US")
       utt.rate = 0.5
       synth.speak(utt)
   }
    func speakThePredictionUsingAudio(fileName: String) {
        guard let audioPath = Bundle.main.path(forResource: fileName, ofType: "wav") else { return }
        let audioURL = URL(fileURLWithPath: audioPath)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
        } catch {
            print("Error loading audio file: \(error.localizedDescription)")
        }
        audioPlayer.play()
   }
}
