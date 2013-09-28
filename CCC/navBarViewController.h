//
//  navBarViewController.h
//  CCC
//
//  Created by Ann Niou on 9/27/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface navBarViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBar;
- (IBAction)backButton:(id)sender;
- (IBAction)helpButton:(id)sender;

@end
