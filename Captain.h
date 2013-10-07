//
//  Captain.h
//  CCC
//
//  Created by Ann Niou on 10/6/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#define kRotationSpeed 0.06
#define kMovementSpeed 200.0

@interface Captain : SKSpriteNode

@property (nonatomic, weak) Captain *Captain;
/* Preload shared animation frames, emitters, etc. */
- (id)initAtPosition:(CGPoint)position withPlayer:(Captain *)Captain;
- (void)initialize;
-(SKSpriteNode*) createCaptain;
- (NSArray *)idleAnimationFrames;
- (NSArray *)walkAnimationFrames;

///* Used by the move: method to move a character in a given direction. */
//typedef enum : uint8_t {
//    CCCMoveDirectionLeft = 0,
//    CCCMoveDirectionRight,
//} CCCMoveDirection;
//
///* The different animation states of an animated character. */
//typedef enum : uint8_t {
//    CCCAnimationStateIdle = 0,
//    CCCAnimationStateWalk,
//} CCCAnimationState;
//
//
//@property (nonatomic) NSString *activeAnimationKey;
//- (void)animationDidComplete:(CCCAnimationState)animation;
//
///* The assets are all facing Y down, so offset by pi half to get into X right facing. */
//#define CCC_POLAR_ADJUST(x) x + (M_PI * 0.5f)
//
//
///* Loop Update - called once per frame. */
//- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)interval;
//
//
//@property (nonatomic, getter=isAnimated) BOOL animated;
//@property (nonatomic) CCCAnimationState requestedAnimation;
//@property (nonatomic) CGFloat animationSpeed;
//@property (nonatomic) CGFloat movementSpeed;
//@property (nonatomic) BOOL moveLeft;
//@property (nonatomic) BOOL moveRight;
//
//#if TARGET_OS_IPHONE
//@property (nonatomic) UITouch *movementTouch;           // used for iOS to track whether a touch is move or fire action
//@property (nonatomic) CGPoint targetLocation;                // used for iOS to track target location
//@property (nonatomic) BOOL moveRequested;               // used for iOS to track whether a move was requested
//#endif
//
//
///* Orientation, Movement, and Attacking. */
//- (void)move:(CCCMoveDirection)direction withTimeInterval:(NSTimeInterval)timeInterval;
//- (CGFloat)faceTo:(CGPoint)position;
//- (void)moveTowards:(CGPoint)position withTimeInterval:(NSTimeInterval)timeInterval;
//- (void)moveInDirection:(CGPoint)direction withTimeInterval:(NSTimeInterval)timeInterval;

- (void)moveLeft;
- (void)moveRight;
@end
