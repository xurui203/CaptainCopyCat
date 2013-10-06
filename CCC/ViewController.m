//
//  ViewController.m
//  CCC
//
//  Created by Ann Niou on 9/27/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import "HomeScreen.h"
#import <SpriteKit/SpriteKit.h>
#import "CCCPracticeModuleMenuPage.h"
@interface ViewController ()
//@property (nonatomic) IBOutlet UIButton *LearningModulesButton;
//@property (nonatomic) IBOutlet UIButton *MazeButton;

@end
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsDrawCount = YES;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [HomeScreen sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
//    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.LearningModulesButton.alpha = 1.0f;
//        self.MazeButton.alpha = 1.0f;
//    } completion:NULL];
    
}


- (void) viewWillAppear:(BOOL)animated
{
    HomeScreen* home = [[HomeScreen alloc] initWithSize:CGSizeMake(1204,800)];
    SKView *spriteView = (SKView*) self.view;
    
    [spriteView presentScene:home];

}
- (BOOL)shouldAutorotate
{
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
//
//- (IBAction)MazeButton:(id)sender {
//}
//@end
@end