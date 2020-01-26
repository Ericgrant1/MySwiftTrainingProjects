//
//  ViewController.swift
//  MySimplePDFViewer
//
//  Created by Eric on 07.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController {

    // 1.
    let pdfFileTitle = "Swift Quick Syntax Reference"
    // 1.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func viewPDFAction(_ sender: UIButton) {
        
        // 2.
        if let urlPdf = Bundle.main.url(forResource: pdfFileTitle, withExtension: "pdf") {
            let webViewPdf = WKWebView(frame: self.view.frame)
            let urlPdfRequest = URLRequest(url: urlPdf)
            webViewPdf.load(urlPdfRequest as URLRequest)
            // self.view.addSubview(webViewPdf)
        // 2.
            // 3.
            let pdfVController = UIViewController()
            pdfVController.view.addSubview(webViewPdf)
            pdfVController.title = pdfFileTitle
            self.navigationController?.pushViewController(pdfVController, animated: true)
            // 3.
        }
    }
    
}

