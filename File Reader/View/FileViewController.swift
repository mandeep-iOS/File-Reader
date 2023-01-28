//
//  FileViewController.swift
//  File Reader
//
//  Created by Deep Baath on 28/01/23.
//

import UIKit
import PDFKit
import AVFoundation
import MobileCoreServices

class FileViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    ///MARK: Outlets
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var speechBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    ///MARK: Constant Instances
    let synthesizer = AVSpeechSynthesizer()
    let viewModel = ViewModel()
    var isSpeechOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        synthesizer.delegate = self
        ///MARK: closure, which takes a single parameter pdfurl, calls the callPDFViewModel(url:) method and pass the pdfurl as parameter.
        viewModel.onDocumentSelected = { [weak self] pdfurl in
            self?.callPDFViewModel(url: pdfurl)
        }
        
    }
    
  ///MARK: callPDFViewModel(url:) method calls the handlePDFViewTask(pdfUrl:_pdfView:) method on the viewModel and pass the pdfurl and pdfView as parameter, it also makes the delete button visible
    func callPDFViewModel(url: URL){
        viewModel.handlePDFViewTask(pdfUrl: url, _pdfView: self.pdfView)
        deleteBtn.isHidden = false
    }
    
    @IBAction func importDocumentBtnAction(_ sender: UIButton){
        ///MARK: first checks if speech is currently active, if so, it calls the showAlert(in:alertMessage:) method on the viewModel and pass the view controller and the .speechRunning alert message as parameters.
        if isSpeechOn {
            viewModel.showAlert(in: self, alertMessage: .speechRunning)
        }else if deleteBtn.isHidden == false{
            viewModel.showAlert(in: self, alertMessage: .deleteExistingFile)
        }else{
            ///MARK: importPDF() method on the viewModel and presents the resulting document picker
            let documentPicker = viewModel.importPDF()
            present(documentPicker, animated: true, completion: nil)
        }
    }

    ///MARK: readTextWithSpeechBtnAction(_:) method is an IBAction method that is triggered when the read text with speech button is pressed. It calls the buttonStateHandling(sender:completion:) method on the viewModel and pass the sender and a closure as parameters.
    @IBAction func readTextWithSpeechBtnAction(_ sender: UIButton){
        
        viewModel.buttonStateHandling(sender: sender) { isSpeechOn, pdfText  in
            ///MARK: closure is triggered and pdfText is empty, it calls the showAlert(in:alertMessage:) method on the viewModel and pass the view controller and the .pdfEmpty alert message as parameters.
            self.isSpeechOn = isSpeechOn
            if pdfText == "" {
                viewModel.showAlert(in: self, alertMessage: .pdfEmpty)
            }
        }
        
    }
    
    ///MARK: deleteFileBtnAction(_:) method is an IBAction method that is triggered when the delete button is pressed.
    @IBAction func deleteFileBtnAction(_ sender: UIButton){
        //checks if speech is currently active, if so, it calls the showAlert(in:alertMessage:) method on the viewModel and pass the view controller and the .cannotDelete alert message as parameters.
        if isSpeechOn {
            viewModel.showAlert(in: self, alertMessage: .cannotDelete)
        }else{
            //If speech is not active, it calls the handleDeleteFile(_pdfView:) method on the viewModel and pass the pdfView as parameter, and make the delete button hidden.
            if pdfView != nil {
                self.deleteBtn.isHidden = viewModel.handleDeleteFile(_pdfView: pdfView)
            }
        }
    }
}
