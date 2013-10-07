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
//    SKSpriteNode *captain = [self createCaptain];
//    
////    SKSpriteNode *captain = [SKSpriteNode spriteNodeWithImageNamed:@"ccc_008.png"];
// 
//    [self addChild:captain];

}

-(SKSpriteNode*) createCaptain {
    SKSpriteNode *captain = [SKSpriteNode spriteNodeWithImageNamed:@"ccc_008"];
    captain.position = CGPointMake(CGRectGetMidX(self.frame)+100,
                                   CGRectGetMidY(self.frame)+150);
    captain.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:captain.size];
    captain.physicsBody.dynamic = YES;
    
    captain.name = @"captain";
    captain.zPosition = 100;
    NSLog(@"createdcaptain");
    return captain;
}

- (NSArray *)idleAnimationFrames {
    return nil;
}

- (NSArray *)walkAnimationFrames {
    return nil;
}


//#pragma mark - Loop Update
//- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)interval {
//    if (self.isAnimated) {
//        [self resolveRequestedAnimation];
//    }
//}
//
//
//#pragma mark - Animation
//- (void)resolveRequestedAnimation {
//    // Determine the animation we want to play.
//    NSString *animationKey = nil;
//    NSArray *animationFrames = nil;
//   CCCAnimationState animationState = self.requestedAnimation;
//    
//    switch (animationState) {
//            
//        default:
//        case CCCAnimationStateIdle:
//            animationKey = @"anim_idle";
//            animationFrames = [self idleAnimationFrames];
//            break;
//            
//        case CCCAnimationStateWalk:
//            animationKey = @"anim_walk";
//            animationFrames = [self walkAnimationFrames];
//            break;
//            
//    }
//    
//    if (animationKey) {
//        [self fireAnimationForState:animationState usingTextures:animationFrames withKey:animationKey];
//    }
//    }
//
//
//- (void)fireAnimationForState:(CCCAnimationState)animationState usingTextures:(NSArray *)frames withKey:(NSString *)key {
//    SKAction *animAction = [self actionForKey:key];
//    if (animAction || [frames count] < 1) {
//        return; // we already have a running animation or there aren't any frames to animate
//    }
//    
//    self.activeAnimationKey = key;
//    [self runAction:[SKAction sequence:@[
//                                         [SKAction animateWithTextures:frames timePerFrame:self.animationSpeed resize:YES restore:NO],
//                                         [SKAction runBlock:^{
//        [self animationHasCompleted:animationState];
//    }]]] withKey:key];
//}
//
//- (void)animationHasCompleted:(CCCAnimationState)animationState {
//    
//    [self animationDidComplete:animationState];
//    
//    self.activeAnimationKey = nil;
//}

//CGFloat CCCDistanceBetweenPoints(CGPoint first, CGPoint second) {
//    return hypotf(second.x - first.x, second.y - first.y);
//}
//
//CGFloat CCCRadiansBetweenPoints(CGPoint first, CGPoint second) {
//    CGFloat deltaX = second.x - first.x;
//    CGFloat deltaY = second.y - first.y;
//    return atan2f(deltaY, deltaX);
//}
//
//CGPoint CCCPointByAddingCGPoints(CGPoint first, CGPoint second) {
//    return CGPointMake(first.x + second.x, first.y + second.y);
//}
//
//
//- (void)move:(CCCMoveDirection)direction withTimeInterval:(NSTimeInterval)timeInterval {
////    CGFloat rot = self.zRotation;
//    
//    SKAction *action = nil;
//    // Build up the movement action.
//    switch (direction) {
//        case CCCMoveDirectionLeft:
//            action = [SKAction rotateByAngle:kRotationSpeed duration:timeInterval];
//            break;
//            
//        case CCCMoveDirectionRight:
//            action = [SKAction rotateByAngle:-kRotationSpeed duration:timeInterval];
//            break;
//    }
//    
//    // Play the resulting action.
//    if (action) {
//        self.requestedAnimation = CCCAnimationStateWalk;
//        [self runAction:action];
//    }
//}
//
//
//
//- (CGFloat)faceTo:(CGPoint)position {
//    CGFloat ang = CCC_POLAR_ADJUST(CCCRadiansBetweenPoints(position, self.position));
//    SKAction *action = [SKAction rotateToAngle:ang duration:0];
//    [self runAction:action];
//    return ang;
//}
//
//- (void)moveTowards:(CGPoint)position withTimeInterval:(NSTimeInterval)timeInterval {
//    CGPoint curPosition = self.position;
//    CGFloat dx = position.x - curPosition.x;
//    CGFloat dy = position.y - curPosition.y;
//    CGFloat dt = self.movementSpeed * timeInterval;
//    
//    CGFloat ang = CCC_POLAR_ADJUST(CCCRadiansBetweenPoints(position, curPosition));
//    self.zRotation = ang;
//    
//    CGFloat distRemaining = hypotf(dx, dy);
//    if (distRemaining < dt) {
//        self.position = position;
//    } else {
//        self.position = CGPointMake(curPosition.x - sinf(ang)*dt,
//                                    curPosition.y + cosf(ang)*dt);
//    }
//    
//    self.requestedAnimation = CCCAnimationStateWalk;
//}
//
//- (void)moveInDirection:(CGPoint)direction withTimeInterval:(NSTimeInterval)timeInterval {
//    CGPoint curPosition = self.position;
//    CGFloat movementSpeed = self.movementSpeed;
//    CGFloat dx = movementSpeed * direction.x;
//    CGFloat dy = movementSpeed * direction.y;
//    CGFloat dt = movementSpeed * timeInterval;
//    
//    CGPoint targetPosition = CGPointMake(curPosition.x + dx, curPosition.y + dy);
//    
//    CGFloat ang = CCC_POLAR_ADJUST(CCCRadiansBetweenPoints(targetPosition, curPosition));
//    self.zRotation = ang;
//    
//    CGFloat distRemaining = hypotf(dx, dy);
//    if (distRemaining < dt) {
//        self.position = targetPosition;
//    } else {
//        self.position = CGPointMake(curPosition.x - sinf(ang)*dt,
//                                    curPosition.y + cosf(ang)*dt);
//    }
//    
//        self.requestedAnimation = CCCAnimationStateWalk;
//}


@end
