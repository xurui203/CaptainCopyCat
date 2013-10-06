//
//  LevelOneMazeScene.h
//  CCC
//
//  Created by Ann Niou on 10/6/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LevelOneMazeScene : SKScene
typedef void (^APAAssetLoadCompletionHandler)(void);

/* Preload shared animation frames, emitters, etc. */
+ (void)loadSharedAssets;


- (void)startLevel;
@end
