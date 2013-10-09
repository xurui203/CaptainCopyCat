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
    captain.position = CGPointMake(CGRectGetMidX(self.frame)-100,
                                   CGRectGetMidY(self.frame) + 450);
    captain.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 1)];
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

#pragma mark - Orientation and Movement
- (void)move:(APAMoveDirection)direction withTimeInterval:(NSTimeInterval)timeInterval {
//    CGFloat rot = self.zRotation;
    
    SKAction *action = nil;
    // Build up the movement action.
    switch (direction) {
            
        case APAMoveDirectionLeft:
            action = [SKAction rotateByAngle:kRotationSpeed duration:timeInterval];
            break;
            
        case APAMoveDirectionRight:
            action = [SKAction rotateByAngle:-kRotationSpeed duration:timeInterval];
            break;
    }
    
    // Play the resulting action.
    if (action) {
        self.requestedAnimation = APAAnimationStateWalk;
        [self runAction:action];
    }
}

//SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"monster"];
//SKTexture *f1 = [atlas textureNamed:@"monster-walk1.png"];
//SKTexture *f2 = [atlas textureNamed:@"monster-walk2.png"];
//SKTexture *f3 = [atlas textureNamed:@"monster-walk3.png"];
//SKTexture *f4 = [atlas textureNamed:@"monster-walk4.png"];
//NSArray *monsterWalkTextures = @[f1,f2,f3,f4];
//



//-(void)moveRight:(SKSpriteNode*)captain {
//    SKAction *hover = [SKAction moveByX:5.0 y:0 duration:1.0];
//    [captain runAction: hover];
//    
//}
//-(void)moveLeft:(SKSpriteNode*)captain {
//    SKAction *hover = [SKAction moveByX:-5.0 y:0 duration:1.0];
//    [captain runAction: hover];
//    
//}




@end
