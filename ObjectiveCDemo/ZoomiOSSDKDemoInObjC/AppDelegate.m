//
//  AppDelegate.m
//  ZoomiOSSDKDemoInObjC
//
//  Created by Zoom Video Communications on 8/18/20.
//  Copyright © 2020 Zoom Video Communications. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <MobileRTC/MobileRTC.h>

@interface AppDelegate() 

@property (nonatomic, copy) NSString *sdkKey;
@property (nonatomic, copy) NSString *sdkSecret;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Obtain your SDK Key and SDK Secret and paste it here.
    // Your SDK Secret should NEVER be publicly accessible, only use the sdk key and secret for testing this demo app.
    // For your own application, you must obtain a JWT instead of using the SDK Key and SDK Secret.
    self.sdkKey = @"";
    self.sdkSecret = @"";

    [self setupSDK:self.sdkKey sdkSecret:self.sdkSecret];
    
    return YES;
}


//Logs the user out of the app upon application termination.
// This is not a necessary action. In real use cases, the SDK should be alerted of app events. For example, in - (void)applicationWillTerminate:(UIApplication *)application, [[MobileRTC sharedRTC] appWillTerminate] should be called.
- (void)applicationWillTerminate:(UIApplication *)application {
    // Obtain the MobileRTCAuthService from the Zoom SDK, this service can log in a Zoom user, log out a Zoom user, authorize the Zoom SDK etc.
    MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];

    // Call logoutRTC() to log the user out.
    if (authService)
        [authService logoutRTC];

    // Notify MobileRTC of appWillTerminate call.
    [[MobileRTC sharedRTC] appWillTerminate];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Notify MobileRTC of appWillResignActive call.
    [[MobileRTC sharedRTC] appWillResignActive];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Notify MobileRTC of appDidBecomeActive call.
    [[MobileRTC sharedRTC] appDidBecomeActive];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Notify MobileRTC of appDidEnterBackgroud call.
    [[MobileRTC sharedRTC] appDidEnterBackgroud];
}


- (void)setupSDK:(NSString *)sdkKey sdkSecret:(NSString *)sdkSecret {
    // Create a MobileRTCSDKInitContext. This class contains attributes for modifying how the SDK will be created. You must supply the context with a domain.
    MobileRTCSDKInitContext *context = [[MobileRTCSDKInitContext alloc] init];
    // The domain we will us is zoom.us
    context.domain = @"zoom.us";
    // Turns on SDK logging. This is optional.
    context.enableLog = YES;

    // Call initialize:(MobileRTCSDKInitContext *_Nonnull)context to create an instance of the Zoom SDK. Without initializing first, the SDK will not do anything. This call will return YES if the SDK was initialized successfully.
    BOOL sdkInitSuc = [[MobileRTC sharedRTC] initialize:context];

    // Check if initialization was successful. Obtain a MobileRTCAuthService, this is for supplying credentials to the SDK for authorization.
    if (sdkInitSuc) {
        MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];

        if (authService) {
            // Supply the SDK with SDK Key and SDK Secret. This is required if a JWT is not supplied.
            // To use a JWT, replace these lines with authorizationService.jwtToken = yourJWTToken;
            authService.clientKey = sdkKey;
            authService.clientSecret = sdkSecret;

            // Assign AppDelegate to be a MobileRTCAuthDelegate to listen for authorization callbacks.
            authService.delegate = self;

            // Call sdkAuth to perform authorization.
            [authService sdkAuth];
        }
    }
}


#pragma mark - MobileRTCAuthDelegate

// Conform AppDelegate to MobileRTCAuthDelegate.
// MobileRTCAuthDelegate listens to authorization events like SDK authorization, user login, etc.

// Result of calling sdkAuth(). MobileRTCAuthError_Success represents a successful authorization.
- (void)onMobileRTCAuthReturn:(MobileRTCAuthError)returnValue {
    switch (returnValue) {
        case MobileRTCAuthError_Success:
            NSLog(@"SDK successfully initialized.");
            break;
        case MobileRTCAuthError_KeyOrSecretEmpty:
            NSLog(@"SDK key/secret was not provided. Replace sdkKey and sdkSecret at the top of this file with your SDK key/secret.");
            break;
        case MobileRTCAuthError_KeyOrSecretWrong:
            NSLog(@"SDK key/secret is not valid.");
            break;
        case MobileRTCAuthError_Unknown:
            NSLog(@"SDK key/secret is not valid.");
            break;
        default:
            NSLog(@"SDK Authorization failed with MobileRTCAuthError: %lu", returnValue);
    }
}

// Result of calling logIn(). 0 represents a successful log in attempt.
- (void)onMobileRTCLoginReturn:(NSInteger)returnValue {
    switch (returnValue) {
        case 0:
            NSLog(@"Successfully logged in");

            // This alerts the ViewController that log in was successful. This is not a necessary action.
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userLoggedIn" object:self];
            break;
        case 1002:
            NSLog(@"Password incorrect");
            break;
        default:
            NSLog(@"Could not log in. Error code: %li", (long)returnValue);
            break;
    }
}

// Result of calling logoutRTC(). 0 represents a successful log out attempt.
- (void)onMobileRTCLogoutReturn:(NSInteger)returnValue {
    switch (returnValue) {
        case 0:
            NSLog(@"Successfully logged out");
            break;
        case 1002:
            NSLog(@"Password incorrect");
            break;
        default:
            NSLog(@"Could not log out. Error code: %li", (long)returnValue);
            break;
    }
}


@end
