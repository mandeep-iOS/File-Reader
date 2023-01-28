//
//  VoiceSpeech.swift
//  File Reader
//
//  Created by Deep Baath on 28/01/23.
//

import UIKit
import AVFoundation
import MobileCoreServices

class VoiceSpeech {
    
    let synthesizer = AVSpeechSynthesizer()
    ///MARK: singleton object "shared" that is used to make voice output of a given text.
    static let shared = VoiceSpeech()
    
    ///MARK: function "makeVoiceOutput" takes one argument "_text" of type String, creates an AVSpeechUtterance object using the input text, sets properties such as rate, pitch, volume, and post utterance delay, and assigns the language and voice. Then the AVSpeechSynthesizer object "synthesizer" uses the AVSpeechUtterance object to start speaking the text
    func makeVoiceOutput(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.57
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.2
        utterance.volume = 0.8
        
        let voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.voice = voice
        synthesizer.speak(utterance)
    }
    ///MARK: function "stopVoiceOutput" stops the speech output immediately using the stopSpeaking method of AVSpeechSynthesizer.
    func stopVoiceOutput() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
}
