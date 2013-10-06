/*
     File: APAPlayer.h
 Abstract: n/a
  Version: 1.2
 

 
 Copyright (C) 2013 Apple Inc. All Rights Reserved.
 
 */

@class Captain, GCController;

#define kStartEnergy 50


@interface APAPlayer : NSObject

@property (nonatomic) Captain *hero;
@property (nonatomic) Class heroClass;

//@property (nonatomic) BOOL moveForward;
//@property (nonatomic) BOOL moveLeft;
//@property (nonatomic) BOOL moveRight;
//@property (nonatomic) BOOL moveBack;
//@property (nonatomic) BOOL fireAction;

@property (nonatomic) CGPoint heroMoveDirection;

@property (nonatomic) uint8_t energyAvailable;
@property (nonatomic) uint32_t score;

@property (nonatomic) GCController *controller;

#if TARGET_OS_IPHONE
@property (nonatomic) UITouch *movementTouch;           // used for iOS to track whether a touch is move or fire action
@property (nonatomic) CGPoint targetLocation;                // used for iOS to track target location
@property (nonatomic) BOOL moveRequested;               // used for iOS to track whether a move was requested
#endif

@end
