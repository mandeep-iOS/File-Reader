//
//  PDFViewerd.swift
//  File Reader
//
//  Created by Deep Baath on 28/01/23.
//

import UIKit
import PDFKit

class PDFViewerd {
    ///MARK: singleton object "shared" that is used to preview a PDF file.
    static let shared = PDFViewerd()
    private init() {}
    
    ///MARK: function called "pdfPreview" which takes three arguments, a pdfUrl of type URL, a _pdfView of type PDFView, and an onCompletion closure. The function then sets properties of the _pdfView, such as the minimum and maximum scale factors, the display mode, and the display direction
    func pdfPreview(pdfUrl: URL, _pdfView: PDFView, onCompletion: (String) -> (Void)){
        _pdfView.minScaleFactor = 0.1
        _pdfView.maxScaleFactor = 5
        _pdfView.autoScales = true
        _pdfView.displayMode = .singlePageContinuous
        _pdfView.displayDirection = .vertical
        ///MARK creates a PDFDocument object using the pdfUrl and assigns it to the _pdfView.
        if let document = PDFDocument(url: pdfUrl) {
            _pdfView.document = document
            ///MARK: calls the onCompletion closure passing the string representation of the PDFDocument as an argument.
            onCompletion(document.string ?? "")
        }
    }
}
