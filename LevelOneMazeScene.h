//
//  LevelOneMazeScene.h
//  CCC
//
//  Created by Ann Niou on 10/6/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define kMinTimeInterval (1.0f / 60.0f)
@interface LevelOneMazeScene : SKScene
typedef void (^APAAssetLoadCompletionHandler)(void);

/* Preload shared animation frames, emitters, etc. */
//+ (void)loadSharedAssets;

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
- (void)startLevel;
- (void)moveLeft;
- (void)moveRight;
@end
