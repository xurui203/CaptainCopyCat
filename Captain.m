//
//  Captain.m
//  CCC
//
//  Created by Ann Niou on 10/6/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import "Captain.h"

@implementation Captain

+ (void)loadSharedAssets {
    // overridden by subclasses
}

#pragma mark - Initialization
- (void)initialize {
    
}

-(SKSpriteNode*) createCaptain {
    SKSpriteNode *captain = [SKSpriteNode spriteNodeWithImageNamed:@"Captain_idle"];
    captain.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame)-150);
    captain.name = @"captain";
    [self addChild:captain];
    
    return captain;
}

- (NSArray *)idleAnimationFrames {
    return nil;
}

- (NSArray *)walkAnimationFrames {
    return nil;
}



@end
