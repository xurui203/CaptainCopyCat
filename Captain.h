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

#define kDefaultNumberOfWalkFrames 28
#define kDefaultNumberOfIdleFrames 28

#ifndef __CAPTAIN_ATLAS__
#define __CAPTAIN_ATLAS__

// ------------------------
// name of the atlas bundle
// ------------------------
#define CAPTAIN_ATLAS_NAME @"Captain"

// ------------
// sprite names
// ------------
#define CAPTAIN_SPR_CCC_001 @"ccc_001"
#define CAPTAIN_SPR_CCC_002 @"ccc_002"
#define CAPTAIN_SPR_CCC_003 @"ccc_003"
#define CAPTAIN_SPR_CCC_004 @"ccc_004"
#define CAPTAIN_SPR_CCC_005 @"ccc_005"
#define CAPTAIN_SPR_CCC_006 @"ccc_006"
#define CAPTAIN_SPR_CCC_007 @"ccc_007"
#define CAPTAIN_SPR_CCC_008 @"ccc_008"
#define CAPTAIN_SPR_CCC_009 @"ccc_009"
#define CAPTAIN_SPR_CCC_010 @"ccc_010"
#define CAPTAIN_SPR_CCC_011 @"ccc_011"
#define CAPTAIN_SPR_CCC_012 @"ccc_012"

// --------
// textures
// --------
#define CAPTAIN_TEX_CCC_001 [SKTexture textureWithImageNamed:@"ccc_001"]
#define CAPTAIN_TEX_CCC_002 [SKTexture textureWithImageNamed:@"ccc_002"]
#define CAPTAIN_TEX_CCC_003 [SKTexture textureWithImageNamed:@"ccc_003"]
#define CAPTAIN_TEX_CCC_004 [SKTexture textureWithImageNamed:@"ccc_004"]
#define CAPTAIN_TEX_CCC_005 [SKTexture textureWithImageNamed:@"ccc_005"]
#define CAPTAIN_TEX_CCC_006 [SKTexture textureWithImageNamed:@"ccc_006"]
#define CAPTAIN_TEX_CCC_007 [SKTexture textureWithImageNamed:@"ccc_007"]
#define CAPTAIN_TEX_CCC_008 [SKTexture textureWithImageNamed:@"ccc_008"]
#define CAPTAIN_TEX_CCC_009 [SKTexture textureWithImageNamed:@"ccc_009"]
#define CAPTAIN_TEX_CCC_010 [SKTexture textureWithImageNamed:@"ccc_010"]
#define CAPTAIN_TEX_CCC_011 [SKTexture textureWithImageNamed:@"ccc_011"]
#define CAPTAIN_TEX_CCC_012 [SKTexture textureWithImageNamed:@"ccc_012"]

// ----------
// animations
// ----------
#define CAPTAIN_ANIM_CCC @[ \
[SKTexture textureWithImageNamed:@"ccc_001"], \
[SKTexture textureWithImageNamed:@"ccc_002"], \
[SKTexture textureWithImageNamed:@"ccc_003"], \
[SKTexture textureWithImageNamed:@"ccc_004"], \
[SKTexture textureWithImageNamed:@"ccc_005"], \
[SKTexture textureWithImageNamed:@"ccc_006"], \
[SKTexture textureWithImageNamed:@"ccc_007"], \
[SKTexture textureWithImageNamed:@"ccc_008"], \
[SKTexture textureWithImageNamed:@"ccc_009"], \
[SKTexture textureWithImageNamed:@"ccc_010"], \
[SKTexture textureWithImageNamed:@"ccc_011"], \
[SKTexture textureWithImageNamed:@"ccc_012"]  \
]


#endif // __CAPTAIN_ATLAS__

/* The different animation states of an animated character. */

@interface Captain : SKSpriteNode
@property (nonatomic) CGFloat animationSpeed;
@property (nonatomic) CGFloat movementSpeed;



@property (nonatomic, weak) Captain *Captain;
/* Preload shared animation frames, emitters, etc. */
//- (id)initAtPosition:(CGPoint)position withPlayer:(Captain *)Captain;
- (void)initialize;
-(SKSpriteNode*) createCaptain;
- (NSArray *)idleAnimationFrames;
- (NSArray *)walkAnimationFrames;
- (NSArray *)getCaptainWalkFrames;

@property (nonatomic, assign) BOOL forwardMarch;
@property (nonatomic, assign) BOOL mightAsWellJump;



/* Assets - should be overridden for animated characters. */

@end


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


