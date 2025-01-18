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
    var url: NSURL?

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
        guard let url = url as URL? else { return }
        imageView.af.setImage(
            withURL: url,
            placeholderImage: nil,
            filter: nil,
            progress: nil
        ) { response in
            let result = try? response.result.get()
            imageView.image = result
            callback(result)
        }
    }
}
