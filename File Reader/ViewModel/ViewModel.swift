//
//  ViewModel.swift
//  File Reader
//
//  Created by Deep Baath on 28/01/23.
//

import UIKit
import PDFKit
import AVFoundation
import MobileCoreServices
import UniformTypeIdentifiers

class ViewModel: NSObject {
    
    ///MARK: Classes Constants
    let pdfClass = PDFViewerd.shared
    let voiceClass = VoiceSpeech.shared
    private let alert = CustomAlert()
    ///MARK: Variable
    var pdfTexts = ""
    ///MARK: Closure
    var onDocumentSelected: ((URL) -> Void)?
    
    func importPDF() -> UIDocumentPickerViewController{
        let supportedTypes: [UTType] = [UTType.pdf]
        let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        pickerViewController.delegate = self
        pickerViewController.allowsMultipleSelection = false
        pickerViewController.shouldShowFileExtensions = true
        pickerViewController.delegate = self
        pickerViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        return pickerViewController
    }
    
    ///MARK: buttonStateHandling(sender: UIButton, onCompletion: (Bool, String?) -> Void) changes the state of the given button and handles the text-to-speech functionality
    func buttonStateHandling(sender: UIButton, onCompletion: (Bool, String?) -> Void) {
        if pdfTexts != ""{
            sender.isSelected = !sender.isSelected
            if sender.isSelected {
                CustomButton.changeButtonState(_title: "Text-Speech On", color: .systemGreen, button: sender)
                handleVoiceTask(isOn: true, pdfText: pdfTexts)
                onCompletion(true, pdfTexts)
            } else {
                CustomButton.changeButtonState(_title: "Text-Speech Off", color: .red, button: sender)
                handleVoiceTask(isOn: false, pdfText: "")
                onCompletion(false, nil)
            }
        }else{
            onCompletion(false, "")
        }
    }
    
    ///MARK : showAlert(in viewController: UIViewController, alertMessage: AlertMessage) displays an alert message in the given view controller
    func showAlert(in viewController: UIViewController, alertMessage: AlertMessage) {
        let customAlert = CustomAlert()
        switch alertMessage {
        case .pdfEmpty:
            customAlert.show(in: viewController, alertMessage: AlertMessage.pdfEmpty.rawValue)
        case .speechRunning:
            customAlert.show(in: viewController, alertMessage: AlertMessage.speechRunning.rawValue)
        case .cannotDelete:
            customAlert.show(in: viewController, alertMessage: AlertMessage.cannotDelete.rawValue)
        case .deleteExistingFile:
            customAlert.show(in: viewController, alertMessage: AlertMessage.deleteExistingFile.rawValue)
        }
    }
    
   ///MARK: handlePDFViewTask(pdfUrl: URL, _pdfView: PDFView) displays the selected PDF file in the given PDFView
    func handlePDFViewTask(pdfUrl: URL, _pdfView: PDFView){
        DispatchQueue.main.async { [weak self] in
            self?.pdfClass.pdfPreview(pdfUrl: pdfUrl, _pdfView: _pdfView) {  _pdfText in
                self?.pdfTexts = _pdfText
            }
        }
    }
    
    ///MARK: handleVoiceTask(isOn: Bool, pdfText: String) starts or stops the text-to-speech functionality
    func handleVoiceTask(isOn: Bool, pdfText: String){
        if isOn {
            voiceClass.makeVoiceOutput(pdfText)
        }else{
            voiceClass.stopVoiceOutput()
        }
    }
    
    ///MARK: handleDeleteFile(_pdfView: PDFView) removes the PDF file from the given PDFView
    func handleDeleteFile(_pdfView: PDFView) -> Bool{
        if _pdfView.documentView?.superview != nil {
            _pdfView.documentView?.removeFromSuperview()
            pdfTexts = ""
            return true
        }
        
        return false
    }
}

///MARK: IDocumentPickerDelegate protocol and has a single method, documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL), which is called when a document is selected and calls the onDocumentSelected closure.
extension ViewModel: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        onDocumentSelected?(url)
    }
}
