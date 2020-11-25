//
//  ViewController.m
//  ZoomiOSSDKDemoInObjC
//
//  Created by Zoom Video Communications on 8/18/20.
//  Copyright © 2020 Zoom Video Communications. All rights reserved.
//

#import "ViewController.h"
#import <MobileRTC/MobileRTC.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    UINavigationController *navController = self.navigationController;

    // The Zoom SDK requires a UINavigationController to update the UI for us. Here we supplied the SDK with the ViewControllers navigationController.
    if (navController)
        [[MobileRTC sharedRTC] setMobileRTCRootController:navController];

    /// Notification that is used to start a meeting upon log in success.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoggedIn) name:@"userLoggedIn" object:nil];
}


#pragma mark - IBOutlets


- (IBAction)joinAMeetingButtonPressed:(UIButton *)sender {
    [self presentJoinMeetingAlert];
}


- (IBAction)startAnInstantMeetingButtonPressed:(UIButton *)sender {
    // Obtain the MobileRTCAuthService from the Zoom SDK.
    MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];

    if (authService) {
        // Check if the user is logged into Zoom.
        BOOL isLoggedIn = [authService isLoggedIn];
        if (isLoggedIn) {
            [self startMeeting];
        } else {
            [self presentLogInAlert];
        }
    }
}

#pragma mark - Zoom SDK Examples


- (void)joinMeeting:(NSString *)meetingNumber meetingPassword:(NSString *)meetingPassword {
    // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
    MobileRTCMeetingService *meetService = [[MobileRTC sharedRTC] getMeetingService];

    if (meetService) {
        // Set the ViewController to be the MobileRTCMeetingServiceDelegate
        meetService.delegate = self;

        // Create a MobileRTCMeetingJoinParam to provide the MobileRTCMeetingService with the necessary info to join a meeting.
        // In this case, we will only need to provide a meeting number and password.
        MobileRTCMeetingJoinParam *joinParams = [[MobileRTCMeetingJoinParam alloc] init];
        joinParams.meetingNumber = meetingNumber;
        joinParams.password = meetingPassword;

        // Call the joinMeeting function in MobileRTCMeetingService. The Zoom SDK will handle the UI for you, unless told otherwise.
        // If the meeting number and meeting password are valid, the user will be put into the meeting. A waiting room UI will be presented or the meeting UI will be presented.
        [meetService joinMeetingWithJoinParam:joinParams];
    }
}


- (void)logIn:(NSString *)email password:(NSString *)password {
    // Obtain the MobileRTCAuthService from the Zoom SDK, this service can log in a Zoom user, log out a Zoom user, authorize the Zoom SDK etc.
    MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];

    if (authService)
        // Call the login function in MobileRTCAuthService. This will attempt to log in the user.
        [authService loginWithEmail:email password:password rememberMe:false];
}


- (void)startMeeting {
    // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
    MobileRTCMeetingService *meetService = [[MobileRTC sharedRTC] getMeetingService];

    if (meetService) {
        // Set the ViewController to be the MobileRTCMeetingServiceDelegate
        meetService.delegate = self;

        // Create a MobileRTCMeetingStartParam to provide the MobileRTCMeetingService with the necessary info to start an instant meeting.
        // In this case we will use MobileRTCMeetingStartParam4LoginlUser, since the user has logged into Zoom.
        MobileRTCMeetingStartParam * startParams = [[MobileRTCMeetingStartParam4LoginlUser alloc] init];

        // Call the startMeeting function in MobileRTCMeetingService. The Zoom SDK will handle the UI for you, unless told otherwise.
        [meetService startMeetingWithStartParam:startParams];
    }
}


#pragma mark - Convenience Alerts


/// Creates alert for prompting the user to enter meeting number and password for joining a meeting.
- (void)presentJoinMeetingAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Join meeting" message:@"" preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Meeting number";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Meeting password";
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = YES;
    }];

    UIAlertAction *joinMeetingAction = [UIAlertAction actionWithTitle:@"Join meeting" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *number = [[alertController textFields][0] text];
        NSString *password = [[alertController textFields][1] text];

        if (number && password)
            [self joinMeeting:number meetingPassword:password];

    }];

    [alertController addAction:joinMeetingAction];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NULL;
    }];

    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


/// Creates alert for prompting the user to enter their Zoom credentials for starting a meeting.
- (void)presentLogInAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Log in" message:@"" preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Email";
        textField.keyboardType = UIKeyboardTypeEmailAddress;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Password";
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = YES;
    }];

    UIAlertAction *logInAction = [UIAlertAction actionWithTitle:@"Log in" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *email = [[alertController textFields][0] text];
        NSString *password = [[alertController textFields][1] text];

        if (email && password)
            [self logIn:email password:password];

    }];

    [alertController addAction:logInAction];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NULL;
    }];

    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Internal

/// Selector that is used to start a meeting upon log in success.
- (void)userLoggedIn {
    [self startMeeting];
}


#pragma mark - MobileRTCMeetingServiceDelegate

// Conform ViewController to MobileRTCMeetingServiceDelegate.
// MobileRTCMeetingServiceDelegate listens to updates about meetings, such as meeting state changes, join attempt status, meeting errors, etc.


- (void)onMeetingError:(MobileRTCMeetError)error message:(NSString *)message {
    switch (error) {
        case MobileRTCMeetError_Success:
            NSLog(@"Successful meeting operation.");
        case MobileRTCMeetError_PasswordError:
            NSLog(@"Could not join or start meeting because the meeting password was incorrect.");
        default:
            NSLog(@"Could not join or start meeting with MobileRTCMeetError: %lu %@", error, message);
    }
}

// Is called when the user joins a meeting.
- (void)onJoinMeetingConfirmed {
    NSLog(@"Join meeting confirmed.");
}


// Is called upon meeting state changes.
- (void)onMeetingStateChange:(MobileRTCMeetingState)state {
    NSLog(@"Current meeting state: %lu", state);
}


@end
