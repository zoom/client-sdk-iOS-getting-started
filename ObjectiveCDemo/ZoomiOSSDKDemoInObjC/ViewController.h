//
//  ViewController.h
//  ZoomiOSSDKDemoInObjC
//
//  Created by Zoom Video Communications on 8/18/20.
//  Copyright © 2020 Zoom Video Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileRTC/MobileRTC.h>

@interface ViewController : UIViewController <MobileRTCMeetingServiceDelegate>

- (IBAction)joinAMeetingButtonPressed:(UIButton *_Nonnull)sender;
- (IBAction)startAnInstantMeetingButtonPressed:(UIButton *_Nonnull)sender;


/// Puts user into ongoing Zoom meeting using a known meeting number and meeting password.
///
/// Assign a MobileRTCMeetingServiceDelegate to listen to meeting events and join meeting status.
/// @param meetingNumber The meeting number of the desired meeting.
/// @param meetingPassword The meeting password of the desired meeting.
/// @pre Zoom SDK must be initialized and authorized.
/// @pre The meeting password of the desired meeting.
- (void)joinMeeting:(nonnull NSString *)meetingNumber meetingPassword:(nonnull NSString*)meetingPassword;

/// Logs user into their Zoom account using the user's Zoom email and password.
///
/// Assign a MobileRTCAuthDelegate to listen to authorization events including onMobileRTCLoginReturn(_ returnValue: Int).
///
/// Assign a MobileRTCMeetingServiceDelegate to listen to meeting events and join meeting status.
/// @param email The user's email address attached to their Zoom account.
/// @param password The user's password attached to their Zoom account.
/// @pre Zoom SDK must be initialized and authorized.
- (void)logIn:(nonnull NSString*)email password:(nonnull NSString*)password;

/// Creates and starts a Zoom instant meeting. An instant meeting is an unscheduled meeting that begins instantly.
///
/// Assign a MobileRTCMeetingServiceDelegate to listen to meeting events and start meeting status.
///
/// Assign a MobileRTCMeetingServiceDelegate to listen to meeting events and join meeting status.
/// @pre Zoom SDK must be initialized and authorized.
/// @pre MobileRTC.shared().setMobileRTCRootController() has been called.
/// @pre User has logged into Zoom successfully.
- (void)startMeeting;


- (void)presentJoinMeetingAlert;
- (void)presentLogInAlert;
- (void)userLoggedIn;

@end

