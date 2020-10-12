# Getting Started with the Zoom iOS SDK 

The simplest and quickest way to start using the Zoom iOS SDK.
This repo contains two seperate Xcode project folders. 

### SwiftDemo

Contains an iOS application built with Swift 5

### ObjectiveCDemo 

Contains an iOS application built with Objective-C

## Prerequisites

1. Install Xcode (10 or higher)
2. Have physical iOS device ready (iOS 8 or higher)
4. Sign into Xcode with valid AppleID or Apple Developer account to be able to generate provisioning profiles
3. Obtain an SDK Key and Secret from the Zoom MarketPlace: https://marketplace.zoom.us/

## Download and run

1. Clone this repo. 
2. For Swift, open the ZoomiOSSDKDemo xcodeproj file in Xcode. For Objective-C, open ZoomiOSSDKDemoInObjC.
3. Navigate to ZoomiOSSDKDemo target -> Signing & Capabilities and provide the target with a provisioning profile. (Both the Swift and Objective-C projects can only be run on a physical device).
4. If using the Swift version navigate to AppDelegate.swift. If using the Objective-C version, navigate to AppDelegate.m.  
5. Replace "sdkKey" and "sdkClient" with the values from your ZoomMarketplace SDK credentials.
6. On a seperate device, or in a browser: Start a real Zoom meeting. Once the meeting has begun, obtain the meeting number and meeting password. 
7. Click run.

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
 
Got the error: "Building for iOS Simulator, but the linked and embedded framework 'MobileRTC.framework' was built for iOS."
  1. You must connect a real iOS device and select it as the build destination.

