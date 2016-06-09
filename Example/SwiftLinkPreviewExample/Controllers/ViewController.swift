//
//  ViewController.swift
//  SwiftLinkPreviewExample
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import UIKit
import SwiftLinkPreview
import SwiftyDrop
import Spring

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var textField: UITextField!
    @IBOutlet var randomTextButton: UIButton!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var postButton: UIButton!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var previewArea: UIView!
    
    // MARK: - Vars
    private let randomTexts: [String] = [
        "Some Vietnamese chars http://vnexpress.net/",
        "Let's try it on Facebook http://facebook.com/ ",
        "Gmail must work http://gmail.com",
        "Well, it's a gif! http://goo.gl/jKCPgp",
        "Japan!!! http://www3.nhk.or.jp/",
        "A Russian website >> http://habrahabr.ru",
        "Youtube?! It does! http://www.youtube.com/watch?v=cv2mjAgFTaI",
        "Also Vimeo http://vimeo.com/67992157",
        "Even with image itself https://lh6.googleusercontent.com/-aDALitrkRFw/UfQEmWPMQnI/AAAAAAAFOlQ/mDh1l4ej15k/w337-h697-no/db1969caa4ecb88ef727dbad05d5b5b3.jpg",
        "NASA! 🖖🏽 http://www.nasa.gov/",
        "Tweet! http://twitter.com",
        "Shorten URL http://bit.ly/14SD1eR",
        "http://uol.com.br"
    ]
    private let tableViewItems: [[String: AnyObject]] = []
    
    private let slp = SwiftLinkPreview()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setUpTableView()
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: - Functions
    private func setUpTableView() {
        
        //        self.tableView.registerNib(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.tableView.tableFooterView = UIView()
        
    }
    
    private func getRandomText() -> String {
        
        return randomTexts[Int(arc4random_uniform(UInt32(randomTexts.count)))]
        
    }
    
    private func startCrawling() {
        
        self.updateUI(false)
        self.textField.resignFirstResponder()
        
    }
    
    private func endCrawling() {
        
        self.updateUI(true)
        
    }
    
    // Update UI
    private func updateUI(enabled: Bool) {
        
        self.indicator.hidden = enabled
        self.textField.enabled = enabled
        self.randomTextButton.enabled = enabled
        self.submitButton.enabled = enabled
        
    }
    
    // MARK: - Actions
    @IBAction func randomTextAction(sender: AnyObject) {
        
        textField.text = getRandomText()
        
    }
    
    @IBAction func submitAction(sender: AnyObject) {
        
        
        guard !(textField.text?.isEmpty)! else {
            
            Drop.down("Please, enter a text", state: .Warning)
            return
            
        }
        
        
        self.startCrawling()
        self.slp.get(
            textField.text,
            onSuccess: { result in
                
                NSLog("\(result)")
                self.endCrawling()
                
            },
            onError: { error in
                
                NSLog("\(error)")
                self.endCrawling()
                
                Drop.down(error.message!, state: .Error)
                
            }
        )
        
    }
    
    @IBAction func postAction(sender: AnyObject) {
        
    }
    
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.submitAction(textField)
        self.textField.resignFirstResponder()
        return true
        
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //        let cell = tableView.dequeueReusableCellWithIdentifier("RoomTableViewCell", forIndexPath: indexPath) as! TableViewCell
        
        return UITableViewCell()
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    
}

