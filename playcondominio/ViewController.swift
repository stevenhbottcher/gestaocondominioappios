//
//  ViewController.swift
//  PlayCondominio
//
//  Created by Paulo Achilles Morato de Carvalho on 27/03/19.
//  Copyright © 2019 AMPM Consultoria em Informática. All rights reserved.
//

import WebKit
import Firebase

class ViewController: UIViewController, WKNavigationDelegate,WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView(){
        webView = WKWebView();
        webView.navigationDelegate = self
        webView?.uiDelegate = self;
        view = webView;
    }
    
    override func viewDidLoad() {
        var url = URL(string: "http://177.70.116.209/Condominio")!
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                url = URL(string: "http://177.70.116.209/Condominio/Home/AcessoIOS?Token="+result.token)!
            }
            self.webView.load(URLRequest(url:url))
            self.webView.allowsBackForwardNavigationGestures = true
        }
    }
    // O código abaixo é usado para que os alerts e confirms do js funcionem no app também
    func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let title = NSLocalizedString("OK", comment: "OK Button")
        let ok = UIAlertAction(title: title, style: .default) { (action: UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true)
        completionHandler()
    }
    
    func webView(_ webView: WKWebView,
                 runJavaScriptTextInputPanelWithPrompt prompt: String,
                 defaultText: String?,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (String?) -> Void) {
        
        let alert = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = defaultText
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            if let text = alert.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            
            completionHandler(nil)
            
        }))
        
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = self.view
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView,
                 runJavaScriptConfirmPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        
        //self.present(alertController, animated: true, completion: nil)
        
        if let presenter = alertController.popoverPresentationController {
            presenter.sourceView = self.view
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //        if ipad will crash on this do this (https://stackoverflow.com/questions/42772973/ios-wkwebview-javascript-alert-crashing-on-ipad?noredirect=1&lq=1):
    //        if let presenter = alertController.popoverPresentationController {
    //            presenter.sourceView = self.view
    //        }
    //
    //        self.present(alertController, animated: true, completion: nil)
}
