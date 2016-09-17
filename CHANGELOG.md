# Change Log

#### 1.x Releases
- `1.0.x` Releases - [1.0.0](#100) | [1.0.1](#101)

#### 0.x Releases
- `0.1.x` Releases - [0.1.0](#010) | [0.1.1](#011) | [0.1.2](#012) | [0.1.3](#013) | [0.1.4](#014) | [0.1.5](#015) | [0.1.6](#016)  
- `0.0.x` Releases - [0.0.2](#002) | [0.0.3](#003)

---

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
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).
- More tests.
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

#### Removed
- Removed unnecessary data from the code such as `style`, `link`, `comments` and `script` for faster analysis. Additionally I've put it inside a `dispatch_async`. [#19](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/19)
	- Removed by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [0.1.3](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.1.3)
Released on 2016-07-16.

#### Added
- Improved URL parsing. No need to add `http://` or `https://` in the start of an URL anymore. [#17](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/17)
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).
- URL parsing tests.
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).
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
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).
- CI. [#5](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/5)
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

#### Fixed
- Crash when parsing pages without title - [#11](https://github.com/LeonardoCardoso/SwiftLinkPreview/issues/11)
	- Fixed by [Fraser](https://github.com/fraserscottmorrison)	

## [0.1.0](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.1.0)
Released on 2016-07-04.

#### Added
- Support for Swift Package Manager. [#3](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/3) [#8](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/8)
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).
- Support for macOS, watchOS, tvOS. [#9](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/9)
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).

## [0.0.3](https://github.com/LeonardoCardoso/Swift-Link-Preview/releases/tag/0.0.3)
Released on 2016-06-25.

#### Added
- Support for Carthage. [#3](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/3) [#7](https://github.com/LeonardoCardoso/Swift-Link-Preview/issues/7)
	- Added by [Leonardo Cardoso](https://github.com/LeonardoCardoso).
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