# Swift Link Preview

It makes a preview from an url, grabbing all the information such as title, relevant texts and images.

[![Platform](https://img.shields.io/cocoapods/p/SwiftLinkPreview.svg?maxAge=2592000)](https://img.shields.io/cocoapods/p/SwiftLinkPreview.svg?maxAge=2592000)
[![CocoaPods](https://img.shields.io/cocoapods/v/SwiftLinkPreview.svg?maxAge=2592000)](https://img.shields.io/cocoapods/v/SwiftLinkPreview.svg?maxAge=2592000)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![LICENSE](https://img.shields.io/cocoapods/l/SwiftLinkPreview.svg?maxAge=2592000)](https://img.shields.io/cocoapods/l/SwiftLinkPreview.svg?maxAge=2592000)

**UTF-8** | **Extended UTF-8**	 |
:--:|:--:|	
![UTF-8](Images/default.gif "UTF-8") | ![Extended UTF-8](Images/langs.gif "Extended UTF-8") |
**Gallery** | **Video Websites** |
![Gallery](Images/gallery.gif "Gallery") | ![Video Websites](Images/videos.gif "Video Websites") |
**Images** | |
![Images](Images/images.gif "Images") |  |

# FLOW

![flow](http://i.imgur.com/SMueQkA.png)

## Requirements and Details

* iOS 8.0+
* Xcode 7.3 or above
* Built with Swift 2.2

## Installation

### CocoaPods

```ruby
	source 'https://github.com/CocoaPods/Specs.git'
	platform :ios, '8.0'
	
	target 'Your Project Name' do
	  	use_frameworks!
	  	// ...
	  	pod 'SwiftLinkPreview', '~> 0.0.3'
	  	// ...
	end
```

### Carthage

```ruby
  	// ...
	github "LeonardoCardoso/SwiftLinkPreview" ~> 0.0.3
  	// ...
```

### Manually

Although it's not recommended, you just need to drop SwiftLinkPreview folder into Xcode project (make sure to enable "Copy items if needed" and "Create groups").


## Usage

#### Instatiating
```swift
import SwiftLinkPreview

// ...

let slp = SwiftLinkPreview()
```

#### Requesting preview
```swift
slp.preview(
    "Text containing url",
    onSuccess: { result in
    	
		print("\(result)")
        
    },
    onError: { error in
       
		print("\(error)")
        
    }
)
```
**result** is a dictionary ```[String: AnyObject]``` like:

```swift
[
   "url": "original URL", 								// NSURL
   "finalUrl": "final ~unshortened~ URL.", 				// NSURL
   "canonicalUrl": "canonical URL", 					// NSURL
   "title": "title", 									// String
   "description": "page description or relevant text", 	// String
   "images": ["array of URLs of the images"], 			// String array
   "image": "main image" 								// String
]
```

#### Cancelling a request
```swift
slp.cancel()
```


## Important

You need to set ```Allow Arbitrary Loads``` to ```YES``` on your project's Info.plist file.

![app security.png](http://i.imgur.com/41hGjCC.png)


## TIPS

Not all websites will have their info brought, you can treat the info that your implementation gets as you like. But here are two tips about posting a preview:

* If some info is missing, you can offer the user to enter it. Take for example the description.
* If more than one image is fetched, you can offer the user the feature of picking one image.

## Information and Contact

Developed by [@LeonardoCardoso](https://github.com/LeonardoCardoso). 

For more information, please visit [http://ios.leocardz.com/swift-link-preview/](http://ios.leocardz.com/swift-link-preview/).

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