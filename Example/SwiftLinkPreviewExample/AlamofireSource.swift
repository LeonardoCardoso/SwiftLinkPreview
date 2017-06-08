//
//  AlamofireSource.swift
//  Pods
//
//  Created by Petr Zvoníček on 14.01.16.
//
// This class is for the Example only

import Alamofire
import AlamofireImage
import ImageSlideshow

public class AlamofireSource: NSObject, InputSource {
    
    var url: NSURL!
    
    public init(url: NSURL) {
        self.url = url
        super.init()
    }
    
    public init?(urlString: String) {
        if let validUrl = NSURL(string: urlString) {
            self.url = validUrl
            super.init()
        } else {
            super.init()
            return nil
        }
    }
    
    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        
        imageView.af_setImage(withURL: self.url as URL, placeholderImage: nil, filter: nil, progress: nil) { (response) in
            
            imageView.image = response.result.value
            
            if let value = response.result.value { callback(value) }
            
        }
    }
    
}
