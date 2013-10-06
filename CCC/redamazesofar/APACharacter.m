/*
     File: APACharacter.m
 Abstract: n/a
  Version: 1.2
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2013 Apple Inc. All Rights Reserved.
 
 */

#import "APACharacter.h"
#import "APAGraphicsUtilities.h"
#import "APAParallaxSprite.h"


@interface APACharacter ()
@end

@implementation APACharacter

#pragma mark - Initialization
- (id)initWithTexture:(SKTexture *)texture atPosition:(CGPoint)position {
    self = [super initWithTexture:texture];
    
    if (self) {
        self.usesParallaxEffect = NO;           // standard sprite - there's no parallax
        [self sharedInitAtPosition:position];
    }
    
    return self;
}

- (id)initWithSprites:(NSArray *)sprites atPosition:(CGPoint)position usingOffset:(CGFloat)offset {
    self = [super initWithSprites:sprites usingOffset:offset];
    if (self) {
        [self sharedInitAtPosition:position];
    }
    
    return self;
}

- (void)sharedInitAtPosition:(CGPoint)position {
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Environment"];

    
    self.position = position;
    
    _energy = 100.0f;
    _movementSpeed = kMovementSpeed;
    _animated = YES;
    _animationSpeed = 1.0f/28.0f;
    
    [self configurePhysicsBody];
}

- (void)reset {
    // Reset some base states (used when recycling character instances).
    self.energy = 100.0f;
    self.animated = YES;
    self.requestedAnimation = APAAnimationStateIdle;
}

#pragma mark - Overridden Methods
- (void)configurePhysicsBody {
    // Overridden by subclasses to create a physics body with relevant collision settings for this character.
}

- (void)animationDidComplete:(APAAnimationState)animation {
    // Called when a requested animation has completed (usually overriden).
}

- (void)collidedWith:(SKPhysicsBody *)other {
    // Handle a collision with another character, projectile, wall, etc (usually overidden).
}
//
//- (void)die {
//    self.energy = 0.0f;
//    self.requestedAnimation = APAAnimationStateDeath;
//}
//

#pragma mark - Loop Update
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)interval {
  
    if (self.isAnimated) {
        [self resolveRequestedAnimation];
    }
}

#pragma mark - Animation
- (void)resolveRequestedAnimation {
    // Determine the animation we want to play.
    NSString *animationKey = nil;
    NSArray *animationFrames = nil;
    APAAnimationState animationState = self.requestedAnimation;
    
    switch (animationState) {
            
        default:
        case APAAnimationStateIdle:
            animationKey = @"anim_idle";
            animationFrames = [self idleAnimationFrames];
            break;
            
        case APAAnimationStateWalk:
            animationKey = @"anim_walk";
            animationFrames = [self walkAnimationFrames];
            break;
            
    }
}

//    if (animationKey) {
//        [self fireAnimationForState:animationState usingTextures:animationFrames withKey:animationKey];
//    }
    
//    self.requestedAnimation = self.dying ? APAAnimationStateDeath : APAAnimationStateIdle;
//}

//- (void)fireAnimationForState:(APAAnimationState)animationState usingTextures:(NSArray *)frames withKey:(NSString *)key {
//    SKAction *animAction = [self actionForKey:key];
//    if (animAction || [frames count] < 1) {
//        return; // we already have a running animation or there aren't any frames to animate
//    }
//    
//    self.activeAnimationKey = key;
//    [self runAction:[SKAction sequence:@[
//                [SKAction animateWithTextures:frames timePerFrame:self.animationSpeed resize:YES restore:NO],
//                [SKAction runBlock:^{
//                    [self animationHasCompleted:animationState];
//                }]]] withKey:key];
//}


- (void)animationHasCompleted:(APAAnimationState)animationState {

    [self animationDidComplete:animationState];
    self.activeAnimationKey = nil;
}

#pragma mark - Working with Scenes
- (void)addToScene:(APAMultiplayerLayeredCharacterScene *)scene {
    [scene addNode:self atWorldLayer:APAWorldLayerCharacter];
}

- (void)removeFromParent {
    [super removeFromParent];
}

- (APAMultiplayerLayeredCharacterScene *)characterScene {
    APAMultiplayerLayeredCharacterScene *scene = (id)[self scene];
    
    if ([scene isKindOfClass:[APAMultiplayerLayeredCharacterScene class]]) {
        return scene;
    } else {
        return nil;
    }
}

#pragma mark - Orientation and Movement
- (void)move:(APAMoveDirection)direction withTimeInterval:(NSTimeInterval)timeInterval {
    CGFloat rot = self.zRotation;

    SKAction *action = nil;
    // Build up the movement action.
    switch (direction) {
        case APAMoveDirectionForward:
            action = [SKAction moveByX:-sinf(rot)*self.movementSpeed*timeInterval y:cosf(rot)*self.movementSpeed*timeInterval duration:timeInterval];
            break;
            
        case APAMoveDirectionBack:
            action = [SKAction moveByX:sinf(rot)*self.movementSpeed*timeInterval y:-cosf(rot)*self.movementSpeed*timeInterval duration:timeInterval];
            break;
            
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

- (CGFloat)faceTo:(CGPoint)position {
    CGFloat ang = APA_POLAR_ADJUST(APARadiansBetweenPoints(position, self.position));
    SKAction *action = [SKAction rotateToAngle:ang duration:0];
    [self runAction:action];
    return ang;
}

- (void)moveTowards:(CGPoint)position withTimeInterval:(NSTimeInterval)timeInterval {
    CGPoint curPosition = self.position;
    CGFloat dx = position.x - curPosition.x;
    CGFloat dy = position.y - curPosition.y;
    CGFloat dt = self.movementSpeed * timeInterval;
    
    CGFloat ang = APA_POLAR_ADJUST(APARadiansBetweenPoints(position, curPosition));
    self.zRotation = ang;
    
    CGFloat distRemaining = hypotf(dx, dy);
    if (distRemaining < dt) {
        self.position = position;
    } else {
        self.position = CGPointMake(curPosition.x - sinf(ang)*dt,
                                    curPosition.y + cosf(ang)*dt);
    }
    
    self.requestedAnimation = APAAnimationStateWalk;
}

- (void)moveInDirection:(CGPoint)direction withTimeInterval:(NSTimeInterval)timeInterval {
    CGPoint curPosition = self.position;
    CGFloat movementSpeed = self.movementSpeed;
    CGFloat dx = movementSpeed * direction.x;
    CGFloat dy = movementSpeed * direction.y;
    CGFloat dt = movementSpeed * timeInterval;
    
    CGPoint targetPosition = CGPointMake(curPosition.x + dx, curPosition.y + dy);
    
    CGFloat ang = APA_POLAR_ADJUST(APARadiansBetweenPoints(targetPosition, curPosition));
    self.zRotation = ang;
    
    CGFloat distRemaining = hypotf(dx, dy);
    if (distRemaining < dt) {
        self.position = targetPosition;
    } else {
        self.position = CGPointMake(curPosition.x - sinf(ang)*dt,
                                    curPosition.y + cosf(ang)*dt);
    }

    // Don't change to a walk animation if we planning an attack.
    if (!self.attacking) {
        self.requestedAnimation = APAAnimationStateWalk;
    }
}

#pragma mark - Shared Assets
+ (void)loadSharedAssets {
    // overridden by subclasses
}

- (NSArray *)idleAnimationFrames {
    return nil;
}

- (NSArray *)walkAnimationFrames {
    return nil;
}


- (NSArray *)deathAnimationFrames {
    return nil;
}


@end
