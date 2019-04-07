![Swift Link Preview](Images/badge.png)

**Link Previewer** for **iOS**, **macOS**, **watchOS** and **tvOS**

> It makes a preview from an URL, grabbing all the information such as title, relevant texts and images.

[![Platform](https://img.shields.io/badge/platform-iOS%20|%20macOS%20|%20watchOS%20|%20tvOS-orange.svg)](https://github.com/LeonardoCardoso/SwiftLinkPreview#requirements-and-details)
[![CocoaPods](https://img.shields.io/badge/pod-v3.0.1-red.svg)](https://github.com/LeonardoCardoso/SwiftLinkPreview#cocoapods)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/LeonardoCardoso/SwiftLinkPreview#carthage)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-orange.svg)](https://github.com/LeonardoCardoso/SwiftLinkPreview#swift-package-manager)
[![Build Status](https://travis-ci.org/LeonardoCardoso/SwiftLinkPreview.svg?branch=master)](https://travis-ci.org/LeonardoCardoso/SwiftLinkPreview)

#### Index

* [Visual Examples](#visual-examples)
* [Requirements and Details](#requirements-and-details)
* [Installation](#installation)
	* [CocoaPods](#cocoapods)
	* [Carthage](#carthage)
	* [Swift Package Manager](#swift-package-manager)
	* [Manually](#manually)
* [Usage](#usage)
	* [Instatiating](#instatiating)
	* [Requesting preview](#requesting-preview)
	* [Cancelling a request](#cancelling-a-request)
* [Flow](#flow)
* [Important](#important)
* [Tips](#tips)
* [Information and Contact](#information-and-contact)
* [Related Projects](#related-projects)
* [License](#license)

<hr />

## Visual Examples

**UTF-8** | **Extended UTF-8**	 | **Gallery**
:--:|:--:|:--:|
![UTF-8](Images/default.gif "UTF-8") | ![Extended UTF-8](Images/langs.gif "Extended UTF-8") |![Gallery](Images/gallery.gif "Gallery")
**Video Websites** | **Images**
![Video Websites](Images/videos.gif "Video Websites") | ![Images](Images/images.gif "Images") |

## Requirements and Details

* iOS 8.0+ / macOS 10.11+ / tvOS 9.0+ / watchOS 2.0+
* Xcode 8.0+
* Built with Swift 3

## Installation

### CocoaPods

To use **SwiftLinkPreview** as a pod package just add the following in your **Podfile** file.

```ruby
	source 'https://github.com/CocoaPods/Specs.git'
	platform :ios, '9.0'

	target 'Your Target Name' do
	  	use_frameworks!
	  	// ...
	  	pod 'SwiftLinkPreview', '~> 3.0.1'
	  	// ...
	end
```

### Carthage

To use **SwiftLinkPreview** as a Carthage module package just add the following in your **Cartfile** file.

```ruby
  	// ...
	github "LeonardoCardoso/SwiftLinkPreview" ~> 3.0.1
  	// ...
```

### Swift Package Manager

To use **SwiftLinkPreview** as a Swift Package Manager package just add the following in your **Package.swift** file.

```swift
import PackageDescription

let package = Package(
  name: "Your Target Name",
  dependencies: [
  	// ...
    .Package(url: "https://github.com/LeonardoCardoso/SwiftLinkPreview.git", "3.0.1")
  	// ...
  ]
)
```

### Manually

You just need to drop all contents in `Sources` folder, **but .plist files**, into Xcode project (make sure to enable "Copy items if needed" and "Create groups").


## Usage

#### Instatiating
```swift
import SwiftLinkPreview

// ...

let slp = SwiftLinkPreview(session: URLSession = URLSession.shared,
			   workQueue: DispatchQueue = SwiftLinkPreview.defaultWorkQueue,
			   responseQueue: DispatchQueue = DispatchQueue.main,
		           cache: Cache = DisabledCache.instance)
```

#### Requesting preview
```swift
slp.preview("Text containing URL",
	    onSuccess: { result in print("\(result)") },
	    onError: { error in print("\(error)")})
```
**result** is a struct ```Response```:

```swift
Response {
	let url: URL // URL
	let finalUrl: URL // unshortened URL
	let canonicalUrl: String // canonical URL
	let title: String // title
	let description: String // page description or relevant text
	let images: [String] // array of URLs of the images
	let image: String // main image
	let icon: String // favicon
	let video: String // video
	let price: String // price
}
```

#### Cancelling a request
```swift
let cancelablePreview = slp.preview(...,
				    onSuccess: ...,
				    onError: ...)

cancelablePreview.cancel()
```

#### Enabling and accessing cache

SLP has a built-in memory cache, so create your object as the following:

```swift
let slp = SwiftLinkPreview(cache: InMemoryCache())
```

To get the cached response:

```swift
if let cached = self.slp.cache.slp_getCachedResponse(url: String) {
    // Do whatever with the cached response
} else {
	// Perform preview otherwise
	slp.preview(...)
}
```

If you want to create your own cache, just implement this protocol and use it on the object initializer.

```swift
public protocol Cache {

    func slp_getCachedResponse(url: String) -> SwiftLinkPreview.Response?

    func slp_setCachedResponse(url: String, response: SwiftLinkPreview.Response?)
}
```

# FLOW

![flow](http://i.imgur.com/SMueQkA.png)

## Important

You need to set ```Allow Arbitrary Loads``` to ```YES``` on your project's Info.plist file.

![app security](http://i.imgur.com/41hGjCC.png)

If you don't want to use the option above and you are using ```SwiftLinkPreview``` for services of your knowledge, you can whitelist them on Info.plist file as well. You can read more about it [here](http://stackoverflow.com/questions/30739473/nsurlsession-nsurlconnection-http-load-failed-on-ios-9), [here](https://github.com/Alamofire/Alamofire#app-transport-security) and [here](https://ste.vn/2015/06/10/configuring-app-transport-security-ios-9-osx-10-11/).

![app security](http://i.imgur.com/INEp6q5.png)

## Tips

Not all websites will have their info brought, you can treat the info that your implementation gets as you like. But here are two tips about posting a preview:

* If some info is missing, you can offer the user to enter it. Take for example the description.
* If more than one image is fetched, you can offer the user the feature of picking one image.

## Tests

Feel free to fork this repo and add URLs on [SwiftLinkPreviewTests/URLs.swift](SwiftLinkPreviewTests/URLs.swift) to test URLs and help improving this lib. The more URLs the better the reliability.

## Information and Contact

Developed by [@LeonardoCardoso](https://github.com/LeonardoCardoso).

Contact me either by Twitter [@leocardz](https://twitter.com/leocardz) or emailing me to [contact@leocardz.com](mailto:contact@leocardz.com).

## Related Projects

* [Link Preview (PHP + Angular + Bootstrap)](https://github.com/LeonardoCardoso/Link-Preview)
* [Android Link Preview](https://github.com/LeonardoCardoso/Android-Link-Preview)


## License

    The MIT License (MIT)

	Copyright (c) 2016 Leonardo Cardoso

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

### Follow me for the latest updates
<a href="https://goo.gl/UC8B8o"><img src="https://i.imgur.com/pac7UMq.png/" width="179" height="26"></a>
