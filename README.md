# Getting Started with the Zoom iOS SDK 

Use of this sample app is subject to our [Terms of Use](https://zoom.us/docs/en-us/zoom_api_license_and_tou.html).

The simplest and quickest way to start using the Zoom iOS SDK.
This repo contains two seperate Xcode project folders. 

### SwiftDemo

Contains an iOS application built with Swift 5

### ObjectiveCDemo 

Contains an iOS application built with Objective-C

## Prerequisites

1. Install Xcode (10 or higher)
2. Have physical iOS device ready (iOS 8 or higher)
3. Sign into Xcode with valid AppleID or Apple Developer account to be able to generate provisioning profiles
4. Obtain an SDK Key and Secret from the Zoom Marketplace: https://marketplace.zoom.us/
5. Download the latest SDK version from the Zoom Marketplace

## Download and run

1. Clone this repo. 
2. Play the MobileRTC.xcframework folder and MobileRTCBundle in the root folder of this directory. This is the same directory as this README.
3. For Swift, open the ZoomiOSSDKDemo xcodeproj file in Xcode. For Objective-C, open ZoomiOSSDKDemoInObjC.
4. Navigate to ZoomiOSSDKDemo target -> Signing & Capabilities and provide the target with a provisioning profile. (Both the Swift and Objective-C projects can only be run on a physical device).
5. If using the Swift version navigate to AppDelegate.swift. If using the Objective-C version, navigate to AppDelegate.m.  
6. Replace "sdkKey" and "sdkClient" with the values from your ZoomMarketplace SDK credentials.
7. On a seperate device, or in a browser: Start a real Zoom meeting. Once the meeting has begun, obtain the meeting number and meeting password. 
8. Click run.

## Features

Upon clicking the Join a Meeting button, an alert displays for the user to supply a meeting number and meeting password. If the credentials are valid the app will join the meeting using the default Zoom meeting UI. 

Upon clicking the Start an Instant Meeting, an alert displays for the user to log into their Zoom account. If the log in is succsessful a Zoom meeting is started on their behalf and the default Zoom meeting UI is displayed. 

## Troubleshooting

Join a Meeting button does nothing:
  1. Check that you have supplied a valid SDK Key and Secret in the appdelegate. 
  2. Set a breakpoint in onMobileRTCAuthReturn in the app delegate. After running the app, ensure that MobileRTCAuthError_Success is the return value.
  3. Set a breakpoint in onMeetingError in the viewController. After running the app and clicking the Join a Meeting Button, ensure MobileRTCMeetError_PasswordError  or other errors are not returned.
  
Nothing happens after clicking log in on the log in alert:
  1. Set a breakpoint in onMobileRTCLoginReturn and observe the return value. If this function does not gett called, double check the log in credentials.

Cant share screen in meeting:
  1. These projects do not support screensharing.
 
Got the error: "Bundle identifier is missing. ZoomiOSSDKDemo doesn't have a bundle identifier. Add a value for PRODUCT_BUNDLE_IDENTIFIER in the build settings editor."
  1. You must supply a unique bundle identifier in the bundle identifier text field under Targets -> ZoomiOSSDKDemo -> Signing & Capabilities -> Bundle Identifier

Got the error: ""ZoomiOSSDKDemo" requires a provisioning profile."
  1. You must supply Xcode a provisioning profile: https://ioscodesigning.com/generating-code-signing-files/

## Need help?

If you're looking for help, try [Developer Support](https://devsupport.zoom.us) or our [Developer Forum](https://devforum.zoom.us). Priority support is also available with [Premier Developer Support](https://zoom.us/docs/en-us/developer-support-plans.html) plans.
