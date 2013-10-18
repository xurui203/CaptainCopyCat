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
    
//    SKSpriteNode *captain = [SKSpriteNode spriteNodeWithImageNamed:@"ccc_008.png"];
//
    [self setCaptainWalkFrames];
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

- (void)setCaptainWalkFrames {
    self.walkFramesRight = self.walkAnimationFrames;
}


- (NSArray *)getCaptainWalkFrames {
    return self.walkFramesRight;
}
- (NSArray *)walkAnimationFrames {
    
    NSMutableArray *walkFrames = [NSMutableArray array];
    SKTextureAtlas *captainAnimatedAtlas = [SKTextureAtlas atlasNamed:@"CCC_running"];
    int numImages = captainAnimatedAtlas.textureNames.count;
    for (int i=1; i <= 9; i++) {
        NSString *textureName = [NSString stringWithFormat:@"ccc_00%d", i];
        SKTexture *run = [captainAnimatedAtlas textureNamed:textureName];
        [walkFrames addObject:run];
    }
    //FIX HARD CODED RUNS 10-12
    SKTexture *run10 = [captainAnimatedAtlas textureNamed:@"ccc_0010"];
    SKTexture *run11= [captainAnimatedAtlas textureNamed:@"ccc_0011"];
    SKTexture *run12= [captainAnimatedAtlas textureNamed:@"ccc_0012"];
    
    [walkFrames addObject:run10];
    [walkFrames addObject:run11];
    [walkFrames addObject:run12];
    
    return walkFrames;
}



@end
