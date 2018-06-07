# Example

This example needs three dependecies to work, add them as you wish:

- [Alamofire] (https://github.com/Alamofire/Alamofire)
- [SwiftyDrop](https://github.com/morizotter/SwiftyDrop)
- [ImageSlideshow](https://github.com/zvonicek/ImageSlideshow)


If you wanna try with `pod`, please create this `Podfile` and run `pod install`:

```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SwiftLinkPreviewExample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SwiftLinkPreviewExample
  pod 'Alamofire'
  pod 'SwiftyDrop'
  pod 'ImageSlideshow'
  pod 'ImageSlideshow/Alamofire'

end
```
