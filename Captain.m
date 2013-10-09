//
//  Captain.m
//  CCC
//
//  Created by Ann Niou on 10/6/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import "Captain.h"

#import <UIKit/UIKit.h>




@implementation Captain



+ (void)loadSharedAssets {
    // overridden by subclasses
}

#pragma mark - Initialization
- (void)initialize {
//    SKSpriteNode *captain = [self createCaptain];
//    
////    SKSpriteNode *captain = [SKSpriteNode spriteNodeWithImageNamed:@"ccc_008.png"];
// 
//    [self addChild:captain];

}

-(SKSpriteNode*) createCaptain {
    SKSpriteNode *captain = [SKSpriteNode spriteNodeWithImageNamed:@"ccc_008"];
//   SKSpriteNode *captain = [SKSpriteNode spriteNodeWithTexture:CAPTAIN_TEX_CCC_001];
//<<<<<<< HEAD
//    captain.position = CGPointMake(CGRectGetMidX(self.frame),
//                                   CGRectGetMidY(self.frame) + 80);
//=======
    captain.position = CGPointMake(CGRectGetMidX(self.frame)-100,
                                   CGRectGetMidY(self.frame) + 450);
    captain.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 1)];
    captain.physicsBody.dynamic = YES;
    captain.physicsBody.usesPreciseCollisionDetection = YES;

    captain.name = @"captain";
//    captain.zPosition = 100;
    NSLog(@"createdcaptain");
    return captain;
}

- (NSArray *)idleAnimationFrames {
    return nil;
}

- (NSArray *)walkAnimationFrames {
    return nil;
}


@end
