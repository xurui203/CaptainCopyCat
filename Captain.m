//
//  Captain.m
//  CCC
//
//  Created by Ann Niou on 10/6/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import "Captain.h"

#import <UIKit/UIKit.h>


@interface Captain ()
//@property (nonatomic) NSTimeInterval lastUpdateTimeInterval; // the previous update: loop time interval
@property BOOL sceneCreated;
@property (nonatomic, strong) NSArray *walkFramesRight;
@end

@implementation Captain



+ (void)loadSharedAssets {
    // overridden by subclasses
}

#pragma mark - Initialization
- (void)initialize {
    SKSpriteNode *captain = [self createCaptain];
    [self addChild:captain];

}

-(SKSpriteNode*) createCaptain {
    SKTexture *temp = self.walkAnimationFrames[0];
    SKSpriteNode *captain = [SKSpriteNode spriteNodeWithTexture:temp];
    
    captain.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    captain.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1, 1)];
    captain.physicsBody.mass = 50.0f;
    captain.physicsBody.dynamic = NO;
    captain.physicsBody.usesPreciseCollisionDetection = YES;

    captain.name = @"captain";
    NSLog(@"createdcaptain");
    return captain;
}

- (NSArray *)idleAnimationFrames {
    return nil;
}

- (NSArray *)walkAnimationFrames {
    
    NSMutableArray *walkFrames = [NSMutableArray array];
    SKTextureAtlas *captainAnimatedAtlas = [SKTextureAtlas atlasNamed:@"CCC_running"];
    int numImages = captainAnimatedAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"ccc_00%d", i];
        SKTexture *run = [captainAnimatedAtlas textureNamed:textureName];
        [walkFrames addObject:run];
    }
    return walkFrames;
}



@end
