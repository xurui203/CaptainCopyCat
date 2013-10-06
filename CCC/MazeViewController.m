//
//  mazeViewController.m
//  CCC
//
//  Created by Ann Niou on 10/5/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//like apaviewcontroller

#import "mazeViewController.h"
#import "APAAdventureScene.h"
#import <SpriteKit/SpriteKit.h>

@interface mazeViewController ()
@property (nonatomic) APAAdventureScene *scene;
@property (nonatomic) IBOutlet SKView *skView;
@property (nonatomic) IBOutlet UIButton *resumeButton;
@property (nonatomic) IBOutlet UIButton *newGameButton;
@end

@implementation mazeViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resumeButton:(id)sender {
    [self startGameWithOption:CCCResume];
}

- (IBAction)newGameButton:(id)sender {
    [self startGameWithOption:CCCNewGame];
}

#pragma mark - View Lifecycle
- (void)viewWillAppear:(BOOL)animated {
    // Start the progress indicator animation.
//    [self.loadingProgressIndicator startAnimating];
    
//    // Load the shared assets of the scene before we initialize and load it.
    [APAAdventureScene loadSceneAssetsWithCompletionHandler:^{
    CGSize viewSize = self.view.bounds.size;

        APAAdventureScene *scene = [[APAAdventureScene alloc] initWithSize:viewSize];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        self.scene = scene;
        
        [scene configureGameControllers];
        
//        [self.loadingProgressIndicator stopAnimating];
//        [self.loadingProgressIndicator setHidden:YES];
        
        [self.skView presentScene:scene];
        
//        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
////            self.archerButton.alpha = 1.0f;
////            self.warriorButton.alpha = 1.0f;
//        } completion:NULL];
    }];
#ifdef SHOW_DEBUG_INFO
    // Show debug information.
    self.skView.showsFPS = YES;
    self.skView.showsDrawCount = YES;
    self.skView.showsNodeCount = YES;
#endif
}

#pragma mark - UI Display and Actions
- (void)hideUIElements:(BOOL)shouldHide animated:(BOOL)shouldAnimate {
    CGFloat alpha = shouldHide ? 0.0f : 1.0f;
    
    if (shouldAnimate) {
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            self.gameLogo.alpha = alpha;
            self.newGameButton.alpha = alpha;
            self.resumeButton.alpha = alpha;
        } completion:NULL];
    } else {
//        [self.gameLogo setAlpha:alpha];
        [self.newGameButton setAlpha:alpha];
        [self.resumeButton setAlpha:alpha];
    }
}

#pragma mark - Starting the Game
- (void)startGameWithOption:(CCCPlayOptions)option {
    [self hideUIElements:YES animated:YES];
    [self.scene setDefaultPlayerHeroType:option];
    [self.scene startLevel];
}

@end
