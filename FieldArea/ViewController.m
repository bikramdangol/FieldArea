//
//  ViewController.m
//  FieldArea
//
//  Created by Bikram Dangol on 11/20/15.
//  Copyright © 2015 AppCoders. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
        FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
        loginButton.center = self.view.center;
        loginButton.delegate = self;
        loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
        [self.view addSubview:loginButton];
        
        if ([FBSDKAccessToken currentAccessToken]) {
                // User is logged in, do work such as go to next view controller.
                [self saveLoggedInUserInformation];
                
        }
        
//        PFUser *user = [PFUser user];
//        user.username = @"fieldarea";
//        user.password = @"myfieldareapassword";
//        user.email = @"fieldarea@appcoders.com";
//        
//        // other fields can be set if you want to save more information
//        user[@"phone"] = @"617-792-2242";
//        
//        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (!error) {
//                        // Hooray! Let them use the app now.
//                } else {
//                        NSString *errorString = [error userInfo][@"error"];
//                        // Show the errorString somewhere and let the user try again.
//                }
//        }];
//        
//        PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//        testObject[@"foo"] = @"bar";
//        [testObject saveInBackground];
}

- (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void) loginButton:	(FBSDKLoginButton *)loginButton didCompleteWithResult:	(FBSDKLoginManagerLoginResult *)result error: (NSError *)error{
        if (!error) {
                NSLog(@"Login successful");
                [self saveLoggedInUserInformation];
        }
        else
        {
                NSLog(@"Login failed");
        }
        
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
      NSLog(@"Logged Out");  
}

- (void) saveLoggedInUserInformation
{
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"id,name,email" forKey:@"fields"];
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                         PFObject *fbCurrentUserID = [PFObject objectWithClassName:@"FBCurrentUserID"];
                         fbCurrentUserID[@"currentUserID"] = [FBSDKAccessToken currentAccessToken].userID;
                         fbCurrentUserID[@"currentUsername"] = result[@"name"];
                         fbCurrentUserID[@"currentUserEmail"] = result[@"email"];
                         NSLog(@"fetched user:%@", result);
                         [fbCurrentUserID saveInBackground];
                 }
         }];

}

@end
