//
//  InstructionsViewController.swift
//  Weathered
//
//  Created by Michael Amiro on 06/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import WebKit

class InstructionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebKitView()
    }
    
    func configureWebKitView() {
        let webKitView = WKWebView()
        view.addSubview(webKitView)
        webKitView.translatesAutoresizingMaskIntoConstraints = false
        webKitView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        webKitView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        webKitView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        webKitView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        webKitView.loadHTMLString(Instructions.html, baseURL: nil)
    }
}
