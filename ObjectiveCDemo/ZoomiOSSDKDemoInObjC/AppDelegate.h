//
//  AppDelegate.h
//  ZoomiOSSDKDemoInObjC
//
//  Created by Zoom Video Communications on 8/18/20.
//  Copyright © 2020 Zoom Video Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileRTC/MobileRTC.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, MobileRTCAuthDelegate>

/// Creates, Initializes, and Authorizes an instance of the Zoom SDK. This must be called before any other SDK functions.
///
/// Assign a MobileRTCAuthDelegate to listen to SDK authorization events. In real applications, SDK Key's and SDK Secret's should not be used as they are highly sensitive data. A JWT should be used instead.
/// Do not leave a JWT, SDK Key, or SDK Secret anywhere that is not secured.
///
/// @param sdkKey A valid SDK Client Key provided by the Zoom Marketplace.
/// @param sdkSecret A valid SDK Client Secret provided by the Zoom Marketplace.
-(void)setupSDK:(NSString *)sdkKey sdkSecret:(NSString *)sdkSecret;

@property (strong, nonatomic) UIWindow *window;

@end

