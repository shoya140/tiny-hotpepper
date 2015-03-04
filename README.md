# tiny-hotpepper

## Requirements

* Xcode 6.3
* iOS SDK 8.3
* cocoapods 0.36.0.rc.1

## How to build

1.Get reqruit web service's api. [リクルートWebサービスAPI](http://webservice.recruit.co.jp/)<br>
2.Replace REQRUIT_WEB_API_KEY to your own api key in THSearchViewControlelr.swift<br>
3.Install pods (AFNetworking, FlatUIKit, SDWebImage).

```
# if you need
$ gem install cocoapods --pre
$ pod setup

$ pod install
```

4.Open tiny-hotpepper.xcworkspace with Xcode6.3(beta)