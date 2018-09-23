//
//  NSURLSessionExtension.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 15/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//
import Foundation

public extension URLSession {

    public func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, NSError?) {

        var data: Data?, response: URLResponse?, error: NSError?
        let semaphore = DispatchSemaphore(value: 0)

        dataTask(with: url, completionHandler: {

            data = $0; response = $1; error = $2 as NSError?
            semaphore.signal()

            }) .resume()

        _ = semaphore.wait(timeout: DispatchTime.distantFuture)

        return (data, response, error)

    }

    public func synchronousDataTask(with request: URLRequest) -> (Data?, URLResponse?, NSError?) {

        var data: Data?, response: URLResponse?, error: NSError?
        let semaphore = DispatchSemaphore(value: 0)

        dataTask(with: request, completionHandler: {

            data = $0; response = $1; error = $2 as NSError?
            semaphore.signal()

            }) .resume()

        _ = semaphore.wait(timeout: DispatchTime.distantFuture)

        return (data, response, error)

    }

}
