//
//  NSURLSessionExtension.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 15/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//
import Foundation

extension NSURLSession {
    
    // Synchronous request to get the real URL
    func synchronousDataTaskWithURL(url: NSURL) -> (NSData?, NSURLResponse?, NSError?) {
        
        var data: NSData?, response: NSURLResponse?, error: NSError?
        let semaphore = dispatch_semaphore_create(0)
        
        dataTaskWithURL(url) {

            data = $0; response = $1; error = $2
            dispatch_semaphore_signal(semaphore)
            
            }.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        return (data, response, error)
        
    }
    
}
