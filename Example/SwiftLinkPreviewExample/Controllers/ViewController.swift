//
//  ViewController.swift
//  SwiftLinkPreviewExample
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import UIKit
import SwiftyDrop
import ImageSlideshow
import SwiftLinkPreview

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var centerLoadingActivityIndicatorView: UIActivityIndicatorView?
    @IBOutlet private weak var textField: UITextField?
    @IBOutlet private weak var randomTextButton: UIButton?
    @IBOutlet private weak var submitButton: UIButton?
    @IBOutlet private weak var openWithButton: UIButton?
    @IBOutlet private weak var indicator: UIActivityIndicatorView?
    @IBOutlet private weak var previewArea: UIView?
    @IBOutlet private weak var previewAreaLabel: UILabel?
    @IBOutlet private weak var slideshow: ImageSlideshow?
    @IBOutlet private weak var previewTitle: UILabel?
    @IBOutlet private weak var previewCanonicalUrl: UILabel?
    @IBOutlet private weak var previewDescription: UILabel?
    @IBOutlet private weak var detailedView: UIView?
    @IBOutlet private weak var favicon: UIImageView?

    // MARK: - Vars
    private var randomTexts: [String] = [
        "blinkist.com",
        "uber.com",
        "tw.yahoo.com",
        "https://www.linkedin.com/",
        "www.youtube.com",
        "www.google.com",
        "facebook.com",

        "https://leocardz.com/swift-link-preview-5a9860c7756f",
        "NASA! 🖖🏽 https://www.nasa.gov/",
        "https://www.theverge.com/2016/6/21/11996280/tesla-offer-solar-city-buy",
        "Shorten URL http://bit.ly/14SD1eR",
        "Tweet! https://twitter.com",

        "A Gallery https://www.nationalgallery.org.uk",
        "www.dji.com/matrice600-pro/info#specs",

        "A Brazilian website http://globo.com",
        "Another Brazilian website https://uol.com.br",
        "Some Vietnamese chars https://vnexpress.net/",
        "Japan!!! https://www3.nhk.or.jp/",
        "A Russian website >> https://habrahabr.ru",

        "Youtube?! It does! https://www.youtube.com/watch?v=cv2mjAgFTaI",
        "Also Vimeo https://vimeo.com/67992157",

        "Even with image itself https://lh6.googleusercontent.com/-aDALitrkRFw/UfQEmWPMQnI/AAAAAAAFOlQ/mDh1l4ej15k/w337-h697-no/db1969caa4ecb88ef727dbad05d5b5b3.jpg",
        "Well, it's a gif! https://goo.gl/jKCPgp"
        ]

    private var result = Response()
    private let placeholderImages = [ImageSource(image: UIImage(named: "Placeholder")!)]

    private let slp = SwiftLinkPreview(cache: InMemoryCache())

    // MARK: - Life cycle
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.showHideAll(hide: true)
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

        self.centerLoadingActivityIndicatorView?.startAnimating()
        self.updateUI(enabled: false)
        self.showHideAll(hide: true)
        self.textField?.resignFirstResponder()
        self.indicator?.isHidden = false

    }

    private func endCrawling() {

        self.updateUI(enabled: true)

    }

    // Update UI
    private func showHideAll(hide: Bool) {

        self.slideshow?.isHidden = hide
        self.detailedView?.isHidden = hide
        self.openWithButton?.isHidden = hide
        self.previewAreaLabel?.isHidden = !hide

    }

    private func updateUI(enabled: Bool) {

        self.indicator?.isHidden = enabled
        self.textField?.isEnabled = enabled
        self.randomTextButton?.isEnabled = enabled
        self.submitButton?.isEnabled = enabled

    }

    private func setData() {

        if let value = self.result.images {

            if !value.isEmpty {

                var images: [InputSource] = []
                for image in value {

                    if let source = AlamofireSource(urlString: image) {

                        images.append(source)

                    }

                }

                self.setImage(images: images)

            } else {

                self.setImage(image: self.result.image)

            }

        } else {

            self.setImage(image: self.result.image)

        }

        if let value: String = self.result.title {

            self.previewTitle?.text = value.isEmpty ? "No title" : value

        } else {

            self.previewTitle?.text = "No title"

        }

        if let value: String = self.result.canonicalUrl {

            self.previewCanonicalUrl?.text = value

        }

        if let value: String = self.result.description {

            self.previewDescription?.text = value.isEmpty ? "No description" : value

        } else {

            self.previewTitle?.text = "No description"

        }

        if let value: String = self.result.icon, let url = URL(string: value) {
            self.favicon?.af_setImage(withURL: url)
        }

        self.showHideAll(hide: false)
        self.endCrawling()

    }

    private func setImage(image: String?) {

        if let image: String = image {

            if !image.isEmpty {

                if let source = AlamofireSource(urlString: image) {

                    self.setImage(images: [source])

                } else {

                    self.slideshow?.setImageInputs(placeholderImages)

                }

            } else {

                self.slideshow?.setImageInputs(placeholderImages)

            }

        } else {

            self.slideshow?.setImageInputs(placeholderImages)

        }

        self.centerLoadingActivityIndicatorView?.stopAnimating()

    }

    private func setImage(images: [InputSource]?) {

        if let images = images {

            self.slideshow?.setImageInputs(images)

        } else {

            self.slideshow?.setImageInputs(placeholderImages)

        }

        self.centerLoadingActivityIndicatorView?.stopAnimating()

    }

    private func setUpSlideshow() {

        self.slideshow?.backgroundColor = UIColor.white
        self.slideshow?.slideshowInterval = 7.0
        self.slideshow?.pageControlPosition = PageControlPosition.hidden
        self.slideshow?.contentScaleMode = .scaleAspectFill

    }

    // MARK: - Actions
    @IBAction func randomTextAction(_ sender: AnyObject) {

        textField?.text = getRandomText()

    }

    @IBAction func submitAction(_ sender: AnyObject) {
        
        func printResult(_ result: Response) {
            print("url: ", result.url ?? "no url")
            print("finalUrl: ", result.finalUrl ?? "no finalUrl")
            print("canonicalUrl: ", result.canonicalUrl ?? "no canonicalUrl")
            print("title: ", result.title ?? "no title")
            print("images: ", result.images ?? "no images")
            print("image: ", result.image ?? "no image")
            print("video: ", result.video ?? "no video")
            print("icon: ", result.icon ?? "no icon")
            print("description: ", result.description ?? "no description")
        }

        guard textField?.text?.isEmpty == false else {

            Drop.down("Please, enter a text", state: .warning)
            return

        }

        self.startCrawling()

        let textFieldText = textField?.text ?? String()

        if let url = self.slp.extractURL(text: textFieldText),
            let cached = self.slp.cache.slp_getCachedResponse(url: url.absoluteString) {

            self.result = cached
            self.setData()

            printResult(result)

        } else {
            self.slp.preview(
                textFieldText,
                onSuccess: { result in

                    printResult(result)
                    
                    self.result = result
                    self.setData()

            },
                onError: { error in

                    print(error)
                    self.endCrawling()

                    Drop.down(error.description, state: .error)

            }
            )
        }

    }

    @IBAction func openWithAction(_ sender: UIButton) {

        if let url = self.result.finalUrl {

            UIApplication.shared.open(url, options: [:], completionHandler: nil)

        }

    }

}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        self.submitAction(textField)
        self.textField?.resignFirstResponder()
        return true

    }

}
