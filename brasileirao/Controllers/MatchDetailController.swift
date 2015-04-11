//
//  MatchDetailController.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/23/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import UIKit
import PKHUD

class MatchDetailController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var matchWebView: UIWebView!
    
    var match:Match?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.matchWebView.delegate = self
        self.matchWebView.hidden = true
        
        HUDController.sharedController.contentView = HUDContentView.ProgressView()
        HUDController.sharedController.show()
        
        let urlString:String! = match?.link
        
        if let url = NSURL(string: urlString) {
            matchWebView.loadRequest(NSURLRequest(URL: url))
        }
        
        self.title = match?.title()
    }
    
    func loadMatch(match: Match) {
        self.match = match
    }

    func webViewDidFinishLoad(webView: UIWebView!) {
        self.matchWebView.hidden = false
        HUDController.sharedController.hide(animated: true)
    }
    
}