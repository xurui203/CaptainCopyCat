//
//  HomeScreen.m
//  CCC
//
//  Created by Ann Niou on 10/3/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import "HomeScreen.h"

@interface HomeScreen()
@property BOOL contentCreated;


@end


@implementation HomeScreen

- (SKLabelNode*)newHomeScreen
{
    SKLabelNode *HomeScreen = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    HomeScreen.text = @"Captain Copy Cat";
    HomeScreen.fontSize = 42;
    HomeScreen.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    return HomeScreen;

    
}
- (void)createSceneContents
{
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild:[self newHomeScreen]];
}

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}



@end
