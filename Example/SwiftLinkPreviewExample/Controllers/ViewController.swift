//
//  ViewController.swift
//  SwiftLinkPreviewExample
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import ImageSlideshow
import SwiftLinkPreview
import SwiftyDrop
import UIKit

class ViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet private var centerLoadingActivityIndicatorView: UIActivityIndicatorView?
    @IBOutlet private var textField: UITextField?
    @IBOutlet private var randomTextButton: UIButton?
    @IBOutlet private var submitButton: UIButton?
    @IBOutlet private var openWithButton: UIButton?
    @IBOutlet private var indicator: UIActivityIndicatorView?
    @IBOutlet private var previewArea: UIView?
    @IBOutlet private var previewAreaLabel: UILabel?
    @IBOutlet private var slideshow: ImageSlideshow?
    @IBOutlet private var previewTitle: UILabel?
    @IBOutlet private var previewCanonicalUrl: UILabel?
    @IBOutlet private var previewDescription: UILabel?
    @IBOutlet private var detailedView: UIView?
    @IBOutlet private var favicon: UIImageView?

    // MARK: - Vars

    private var randomTexts: [String] = [
        "blinkist.com",
        "uber.com",
        "tw.yahoo.com",
        "https://www.linkedin.com/",
        "www.youtube.com",
        "www.google.com",
        "facebook.com",

        "https://github.com/LeonardoCardoso/SwiftLinkPreview",
        "https://www.jbhifi.com.au/products/playstation-4-biomutant",

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

        "Well, it's a gif! https://goo.gl/jKCPgp",
    ]

    private var result = Response()
    private let placeholderImages = [ImageSource(image: UIImage(named: "Placeholder")!)]

    private let slp = SwiftLinkPreview(cache: InMemoryCache())

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        showHideAll(hide: true)
        setUpSlideshow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func getRandomText() -> String {
        return randomTexts[Int(arc4random_uniform(UInt32(randomTexts.count)))]
    }

    private func startCrawling() {
        centerLoadingActivityIndicatorView?.startAnimating()
        updateUI(enabled: false)
        showHideAll(hide: true)
        textField?.resignFirstResponder()
        indicator?.isHidden = false
    }

    private func endCrawling() {
        updateUI(enabled: true)
    }

    // Update UI
    private func showHideAll(hide: Bool) {
        slideshow?.isHidden = hide
        detailedView?.isHidden = hide
        openWithButton?.isHidden = hide
        previewAreaLabel?.isHidden = !hide
    }

    private func updateUI(enabled: Bool) {
        indicator?.isHidden = enabled
        textField?.isEnabled = enabled
        randomTextButton?.isEnabled = enabled
        submitButton?.isEnabled = enabled
    }

    private func setData() {
        if let value = result.images {
            if !value.isEmpty {
                var images: [InputSource] = []
                for image in value {
                    if let source = AlamofireSource(urlString: image) {
                        images.append(source)
                    }
                }

                setImage(images: images)
            } else {
                setImage(image: result.image)
            }
        } else {
            setImage(image: result.image)
        }

        if let value: String = result.title {
            previewTitle?.text = value.isEmpty ? "No title" : value
        } else {
            previewTitle?.text = "No title"
        }

        if let value: String = result.canonicalUrl {
            previewCanonicalUrl?.text = value
        }

        if let value: String = result.description {
            previewDescription?.text = value.isEmpty ? "No description" : value
        } else {
            previewTitle?.text = "No description"
        }

        if let value: String = result.icon, let url = URL(string: value) {
            favicon?.af.setImage(withURL: url)
        }

        showHideAll(hide: false)
        endCrawling()
    }

    private func setImage(image: String?) {
        if let image: String = image {
            if !image.isEmpty {
                if let source = AlamofireSource(urlString: image) {
                    setImage(images: [source])
                } else {
                    slideshow?.setImageInputs(placeholderImages)
                }
            } else {
                slideshow?.setImageInputs(placeholderImages)
            }
        } else {
            slideshow?.setImageInputs(placeholderImages)
        }

        centerLoadingActivityIndicatorView?.stopAnimating()
    }

    private func setImage(images: [InputSource]?) {
        if let images = images {
            slideshow?.setImageInputs(images)
        } else {
            slideshow?.setImageInputs(placeholderImages)
        }

        centerLoadingActivityIndicatorView?.stopAnimating()
    }

    private func setUpSlideshow() {
        slideshow?.backgroundColor = UIColor.white
        slideshow?.slideshowInterval = 7.0
        slideshow?.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        slideshow?.contentScaleMode = .scaleAspectFill
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
            print("baseURL: ", result.baseURL ?? "no baseURL")
        }

        guard textField?.text?.isEmpty == false else {
            Drop.down("Please, enter a text", state: .warning)
            return
        }

        startCrawling()

        let textFieldText = textField?.text ?? String()

        if let url = slp.extractURL(text: textFieldText),
           let cached = slp.cache.slp_getCachedResponse(url: url.absoluteString) {
            result = cached
            setData()

            printResult(result)
        } else {
            slp.preview(
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
        if let url = result.finalUrl {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submitAction(textField)
        self.textField?.resignFirstResponder()
        return true
    }
}
