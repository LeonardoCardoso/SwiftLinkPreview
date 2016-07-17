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
import ImageSlideshow

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var textField: UITextField!
    @IBOutlet var randomTextButton: UIButton!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var openWithButton: UIButton!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var previewArea: UIView!
    @IBOutlet var previewAreaLabel: UILabel!
    @IBOutlet var slideshow: ImageSlideshow!
    @IBOutlet var previewTitle: UILabel!
    @IBOutlet var previewCanonicalUrl: UILabel!
    @IBOutlet var previewDescription: UILabel!
    @IBOutlet var detailedView: UIView!
    
    // MARK: - Vars
    private var randomTexts: [String] = [
        
        "www.google.com",
        
        "http://ios.leocardz.com/swift-link-preview/",
        "NASA! 🖖🏽 http://www.nasa.gov/",
        "http://www.theverge.com/2016/6/21/11996280/tesla-offer-solar-city-buy",
        "Shorten URL http://bit.ly/14SD1eR",
        "Tweet! https://twitter.com",
        
        "A Gallery https://www.nationalgallery.org.uk",
        
        "A Brazilian website http://globo.com",
        "Another Brazilian website http://uol.com.br",
        "Some Vietnamese chars http://vnexpress.net/",
        "Japan!!! http://www3.nhk.or.jp/",
        "A Russian website >> http://habrahabr.ru",
        
        "Youtube?! It does! http://www.youtube.com/watch?v=cv2mjAgFTaI",
        "Also Vimeo http://vimeo.com/67992157",
        
        "Even with image itself https://lh6.googleusercontent.com/-aDALitrkRFw/UfQEmWPMQnI/AAAAAAAFOlQ/mDh1l4ej15k/w337-h697-no/db1969caa4ecb88ef727dbad05d5b5b3.jpg",
        "Well, it's a gif! http://goo.gl/jKCPgp"
        
    ]
    private var result: [String: AnyObject] = [:]
    private let placeholderImages = [ImageSource(image: UIImage(named: "Placeholder")!)]
    
    private let slp = SwiftLinkPreview()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.showHideAll(true)
        self.setUpSlideshow()

    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    private func getRandomText() -> String {
        
        return randomTexts[Int(arc4random_uniform(UInt32(randomTexts.count)))]
        
    }
    
    private func startCrawling() {
        
        self.updateUI(false)
        self.showHideAll(true)
        self.textField.resignFirstResponder()
        
    }
    
    private func endCrawling() {
        
        self.updateUI(true)
        
    }
    
    // Update UI
    private func showHideAll(hide: Bool) {
        
        self.slideshow.hidden = hide
        self.detailedView.hidden = hide
        self.openWithButton.hidden = hide
        self.previewAreaLabel.hidden = !hide
        
    }
    
    private func updateUI(enabled: Bool) {
        
        self.indicator.hidden = enabled
        self.textField.enabled = enabled
        self.randomTextButton.enabled = enabled
        self.submitButton.enabled = enabled
        
    }
    
    private func setData() {
        
        if let value: [String] = self.result["images"] as? [String] {
            
            if !value.isEmpty {
                
                var images: [InputSource] = []
                for image in value {
                    
                    if let source: AlamofireSource = AlamofireSource(urlString: image) {
                        
                        images.append(source)
                        
                    }
                    
                }
                
                self.setImage(images)
                
                
            } else {
                
                self.setImage(self.result["image"] as? String)
                
            }
            
        } else {
            
            self.setImage(self.result["image"] as? String)
            
        }
        
        if let value: String = self.result["title"] as? String {
            
            self.previewTitle.text = value.isEmpty ? "No title" : value
            
        } else {
            
            self.previewTitle.text = "No title"
            
        }
        
        if let value: String = self.result["canonicalUrl"] as? String {
            
            self.previewCanonicalUrl.text = value
            
        }
        
        if let value: String = self.result["description"] as? String {
            
            self.previewDescription.text = value.isEmpty ? "No description" : value
            
        } else {
            
            self.previewTitle.text = "No description"
            
        }
        
        self.showHideAll(false)
        self.endCrawling()
        
    }
    
    private func setImage(image: String?) {
        
        if let image: String = image {
            
            if !image.isEmpty {
                
                if let source: AlamofireSource = AlamofireSource(urlString: image) {
                    
                    self.setImage([source])
                    
                } else {
                    
                    self.slideshow.setImageInputs(placeholderImages)
                    
                }
                
                
            } else {
                
                self.slideshow.setImageInputs(placeholderImages)
                
            }
            
        } else {
            
            self.slideshow.setImageInputs(placeholderImages)
            
        }
        
    }
    
    private func setImage(images: [InputSource]?) {
        
        if let images = images {
            
            self.slideshow.setImageInputs(images)
            
        } else {
            
            self.slideshow.setImageInputs(placeholderImages)
            
        }
        
    }
    
    private func setUpSlideshow() {
        
        self.slideshow.backgroundColor = UIColor.whiteColor()
        self.slideshow.slideshowInterval = 7.0
        self.slideshow.pageControlPosition = PageControlPosition.Hidden
        self.slideshow.contentScaleMode = .ScaleAspectFill
        
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
        self.slp.preview(
            textField.text,
            onSuccess: { result in
                
                print(result)
                self.result = result
                self.setData()
                
            },
            onError: { error in
                
                print(error)
                self.endCrawling()
                
                Drop.down(error.message!, state: .Error)
                
            }
        )
        
    }
    
    @IBAction func openWithAction(sender: UIButton) {
        
        if let url: NSURL = self.result["finalUrl"] as? NSURL {
            
            UIApplication.sharedApplication().openURL(url)
            
        }
        
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

