//
//  ViewController.swift
//  SwiftLinkPreviewExample
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import UIKit
import SwiftLinkPreview

class ViewController: UIViewController {
    
    // MARK: - Vars
    private let randomUrls = [
        "http://vnexpress.net/ ",
        "http://facebook.com/ ",
        "http://gmail.com",
        "http://goo.gl/jKCPgp",
        "http://www3.nhk.or.jp/",
        "http://habrahabr.ru",
        "http://www.youtube.com/watch?v=cv2mjAgFTaI",
        "http://vimeo.com/67992157",
        "https://lh6.googleusercontent.com/-aDALitrkRFw/UfQEmWPMQnI/AAAAAAAFOlQ/mDh1l4ej15k/w337-h697-no/db1969caa4ecb88ef727dbad05d5b5b3.jpg",
        "http://www.nasa.gov/", "http://twitter.com",
        "http://bit.ly/14SD1eR"
    ]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let slp = SwiftLinkPreview()
        
        slp.get(
            getRandomUrl(),
            onSuccess: { result in
                
                NSLog("\(result)")
                
            },
            onError: { error in
    
                NSLog("\(error)")
    
            }
        )
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    // MARK: - Functions
    func getRandomUrl() -> String {
        
        return randomUrls[Int(arc4random_uniform(UInt32(randomUrls.count)) + 1)]
        
    }
    
}

