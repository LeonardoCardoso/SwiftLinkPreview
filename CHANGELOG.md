# Change Log

#### 3.x Releases
- `3.1.x` Releases - [3.1.0](#310)
- `3.0.x` Releases - [3.0.0](#300) | [3.0.1](#301)

#### 2.x Releases
- `2.3.x` Releases - [2.3.0](#230) | [2.3.1](#231)
- `2.2.x` Releases - [2.2.0](#220)
- `2.1.x` Releases - [2.1.0](#210)
- `2.0.x` Releases - [2.0.0](#200) | [2.0.1](#201) | [2.0.2](#202) | [2.0.3](#203) | [2.0.4](#204) | [2.0.5](#205) | [2.0.6](#206) | [2.0.7](#207)

#### 1.x Releases
- `1.0.x` Releases - [1.0.0](#100) | [1.0.1](#101)

#### 0.x Releases
- `0.1.x` Releases - [0.1.0](#010) | [0.1.1](#011) | [0.1.2](#012) | [0.1.3](#013) | [0.1.4](#014) | [0.1.5](#015) | [0.1.6](#016)
- `0.0.x` Releases - [0.0.2](#002) | [0.0.3](#003)

---
## [3.1.0](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/3.1.0)

#### Changed

- Swift 5 compatibility
    - Added by [Rajesh](https://github.com/rajeshbeats)
- Fixed lack case nil when unwrap data
    - Added by [Quang Truong Tuan](https://github.com/tuanquanghpvn)

## [3.0.1](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/3.0.1)

#### Added

- Added schema.org price crawler
    - Added by [William Gossard](https://github.com/nova974)


## [3.0.0](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/3.0.0)
Released on 2019-01-02.

#### Added

- Added isVideo() check
	- Added by [Onur Genes](https://github.com/onurgenes)

#### Changed
- Response is now a swift `struct` instead of a `Dictionary<String, Any>`
- Moving to Swift 4.2
	- Changed by [Giuseppe Travasoni](https://github.com/neobeppe)

## [2.3.1](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.3.1)
Released on 2018-09-23.

#### Changed

- Fixed missing Accept header
	- Changed by [Maarten Billemont](https://github.com/lhunath)
- Example with Cocoapods
    - Changed by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [2.3.0](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.3.0)
Released on 2018-06-07.

#### Changed

- Improved scraping - issues [#70](https://github.com/LeonardoCardoso/SwiftLinkPreview/issues/70) [#86](https://github.com/LeonardoCardoso/SwiftLinkPreview/issues/86)
- Handle in-url redirections - issue [#83](https://github.com/LeonardoCardoso/SwiftLinkPreview/issues/83)
- Swift 4.2 Compatibility - issue [#85](https://github.com/LeonardoCardoso/SwiftLinkPreview/issues/85)
    - Changed by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [2.2.0](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.2.0)
Released on 2018-01-06.

#### Changed

- Improved scraping
- Improved error logging
- Retry as GET if HEAD is redirected
- String charset set to UTF16
- No force wrapping
    - Changed by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [2.1.0](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.1.0)
Released on 2017-11-09.

#### Added

- Swift 4 - pr [#67](https://github.com/LeonardoCardoso/SwiftLinkPreview/pull/67).
    - Added by [Stephen Hayes](https://github.com/schayes04).

## [2.0.7](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.0.7)
Released on 2017-07-24.

#### Added

- `Extract icon` - pr [#60](https://github.com/LeonardoCardoso/SwiftLinkPreview/pull/60).
    - Added by [Vincent Toms](https://github.com/vinnyt).

## [2.0.6](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.0.6)
Released on 2017-07-06.

#### Changed

- `NSDataDetector` - pr [#56](https://github.com/LeonardoCardoso/SwiftLinkPreview/pull/56).
    - Changed by [Vincent Toms](https://github.com/vinnyt).

## [2.0.5](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.0.5)
Released on 2017-06-08.

#### Changed

- `extractURL` made public - issue [#52](https://github.com/LeonardoCardoso/SwiftLinkPreview/issues/52).
    - Changed by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [2.0.4](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.0.4)
Released on 2017-04-15.

#### Changed

- Whitespace and new lines - issue [#47](https://github.com/LeonardoCardoso/SwiftLinkPreview/issues/47).
- Support for macOS 10.10 - issue [#48](https://github.com/LeonardoCardoso/SwiftLinkPreview/issues/48).
    - Changed by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [2.0.3](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.0.3)
Released on 2017-03-13.

#### Changed

- Renamed the Objective-C compatible wrapper fro the preview method to previewLink. This resolves ambiguous method errors in Swift builds - issue [#41](https://github.com/LeonardoCardoso/SwiftLinkPreview/issues/41).
    - Changed by [David Gifford](https://github.com/giffnyc).

## [2.0.2](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.0.2)
Released on 2017-03-09.

#### Added
- Objective-C init method with no parameters, defaults to the same options as the Swift default parameters.
- Objective-C init method which allows user to set parameters - passing nil will default the parameters. InMemoryCache is a BOOL parameter to use or not use a cache.
- Objective-C preview method which returns a dictionary of values on success, and an NSError object on failure which contains a localized error description.
	- Added by [David Gifford](https://github.com/giffnyc).

#### Changed
- Referenced objects are now derived from NSObject to make them Objective-C compatible.
	- Changed by [David Gifford](https://github.com/giffnyc).

## [2.0.1](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.0.1)
Released on 2017-02-24.

#### Changed
- Local analysis out of threads.
- iOS8 backport compatibility
    - Changed by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

#### Fixed
- Crash when no URL was sent to SLP.
	- Fixed by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [2.0.0](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/2.0.0)
Released on 2017-01-19.

#### Changed
- Fully asynchronous (DispatchQueue).
- Removed global state
- Better response dictionary subscription via Enum
- Configurable via constructor (URLSession, Work Queue, Response Queue)
	- Changed by [Yehor Popovych](https://github.com/ypopovych).

#### Added
- Caching support (InMemoryCache, but can be extended to other types)
	- Added by [Yehor Popovych](https://github.com/ypopovych).

#### API breaking changes
- Subscriptions via Enum require changes in current code
- `preview` method returns a Cancellable object with cancel method. This allows reusing of single configured SLP instance for multiple requests. cancel method removed from SwiftLinkPreview class.

<br /><hr ><br />

## [1.0.1](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/1.0.1)
Released on 2016-09-17.

#### Added
- Compatibility with Obj-C.
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [1.0.0](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/1.0.0)
Released on 2016-09-14.

#### Added
- Major Version 1.0.0 with Swift 3.0.
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

<br /><hr ><br />

## [0.1.6](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.1.6)
Released on 2016-09-04.

#### Fixed
- PreviewError conformance to ErrorType.
	- Fixed by [Daniel Rhodes](https://github.com/danielrhodes).

## [0.1.5](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.1.5)
Released on 2016-07-19.

#### Added
- Background task.
	- Added by [Fraser](https://github.com/fraserscottmorrison).

#### Removed
- Removed resources from podspec file.
	- Removed by [Fraser](https://github.com/fraserscottmorrison).

## [0.1.4](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.1.4)
Released on 2016-07-19.

#### Added
- Improved crawling. `itemprop` is now a supported meta property.
- More tests.
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

#### Removed
- Removed unnecessary data from the code such as `style`, `link`, `comments` and `script` for faster analysis. Additionally I've put it inside a `dispatch_async`. [#19](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/19)
	- Removed by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [0.1.3](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.1.3)
Released on 2016-07-16.

#### Added
- Improved URL parsing. No need to add `http://` or `https://` in the start of an URL anymore. [#17](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/17)
- URL parsing tests.
- Tests for other platforms.
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

#### Fixed
- Image url uses finalUrl host component rather than its full path
	- Fixed by [Fraser](https://github.com/fraserscottmorrison)


## [0.1.2](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.1.2)
Released on 2016-07-13.

#### Added
- Improved way to get the info. [#13](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/13)
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

#### Removed
- Remove Package.swift from .xcproject to avoid build issues. Still supporting SPM though. [#16](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/16)
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [0.1.1](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.1.1)
Released on 2016-07-11.

#### Added
- Tests. [#1](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/1)
- CI. [#5](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/5)
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

#### Fixed
- Crash when parsing pages without title - [#11](https://github.com/LeonardoCardoso/SwiftLinkPreview/issues/11)
	- Fixed by [Fraser](https://github.com/fraserscottmorrison)

## [0.1.0](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.1.0)
Released on 2016-07-04.

#### Added
- Support for Swift Package Manager. [#3](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/3) [#8](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/8)
- Support for macOS, watchOS, tvOS. [#9](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/9)
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [0.0.3](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.0.3)
Released on 2016-06-25.

#### Added
- Support for Carthage. [#3](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/3) [#7](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/7)
- GitHub configs
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

#### Removed
- Alamofire. [#6](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/6)
	- Removed by [Leonardo Cardoso](https://github.com/LeonardoCardoso).


## [0.0.2](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.0.2)
Released on 2016-06-23.

#### Added
- Initial release of SwiftLinkPreview.
  - Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).
