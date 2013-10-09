//
//  LevelOneMazeViewController.m
//  CCC
//
//  Created by Xu Rui on 6/10/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import "LevelOneMazeViewController.h"
#import "LevelOneMazeScene.h"
#import "Captain.h"

@interface LevelOneMazeViewController ()
@property (weak, nonatomic) IBOutlet SKView *skView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UITextView *levelDescription;
@property (nonatomic, readwrite) LevelOneMazeScene *levelOneScene;
- (IBAction)playLevelButton:(id)sender;

@property (weak, nonatomic) IBOutlet SKView *SuperpowerDrawer;
@property (weak, nonatomic) IBOutlet UIButton *moveLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *moveRightButton;

- (IBAction)superpowerDrawerButton:(id)sender;

@end

@implementation LevelOneMazeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.moveLeftButton setHidden:YES];
    [self.moveRightButton setHidden:YES];

	// Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    CGSize viewSize = self.view.bounds.size;

    LevelOneMazeScene *levelOneScene = [[LevelOneMazeScene alloc] initWithSize:viewSize];
    levelOneScene.scaleMode = SKSceneScaleModeAspectFill;
    self.levelOneScene = levelOneScene;
    
    [self.skView presentScene:levelOneScene];
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [self hideSuperPowerDrawer:YES animated:YES];
        [self.SuperpowerDrawer setHidden:YES];
        self.levelDescription.alpha = 1.0f;
        self.playButton.alpha = 1.0f;
    } completion:NULL];

#ifdef SHOW_DEBUG_INFO
// Show debug information.
self.skView.showsFPS = YES;
self.skView.showsDrawCount = YES;
self.skView.showsNodeCount = YES;
#endif
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)hideUIOptions:(BOOL)shouldHide animated:(BOOL)shouldAnimate {
    CGFloat alpha = shouldHide ? 0.0f : 1.0f;
    
    if (shouldAnimate) {
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.levelDescription.alpha = alpha;
            self.playButton.alpha = alpha;
        } completion:NULL];
    } else {
        [self.levelDescription setAlpha:alpha];
        [self.playButton setAlpha:alpha];
    }

}

- (IBAction)moveLeftButton:(id)sender {

}

- (IBAction)moveRightButton:(id)sender {
    //    [self.levelOneScene runAction:self.levelOneScene.sequence];
    [self.levelOneScene moveRight];
}


- (void)hideSuperPowerDrawer:(BOOL)shouldHide animated:(BOOL)shouldAnimate {
    CGFloat alpha = shouldHide ? 0.0f : 1.0f;
    
    if (shouldAnimate) {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.SuperpowerDrawer.alpha = alpha;
        } completion:NULL];
    } else {
        [self.SuperpowerDrawer setAlpha:alpha];
    }
}


- (IBAction)playLevelButton:(id)sender {
    [self hideUIOptions:YES animated:YES];
    [self.levelOneScene startLevel];
    [self.moveLeftButton setHidden:NO];
    [self.moveRightButton setHidden:NO];
}

- (IBAction)superpowerDrawerButton:(id)sender {
    if (self.SuperpowerDrawer.hidden) {
        [self.SuperpowerDrawer setHidden:NO];
    }
    else {
        [self.SuperpowerDrawer setHidden:YES];
    }
    
}

@end