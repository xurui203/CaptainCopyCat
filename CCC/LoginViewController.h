//
//  LoginViewController.h
//  CCC
//
//  Created by Ann Niou on 9/27/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
- (IBAction)loginButton:(id)sender;
- (IBAction)signUpButton:(id)sender;

@end
