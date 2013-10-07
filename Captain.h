//
//  Captain.h
//  CCC
//
//  Created by Ann Niou on 10/6/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Captain : SKSpriteNode

@property (nonatomic, weak) Captain *Captain;
/* Preload shared animation frames, emitters, etc. */
//- (id)initAtPosition:(CGPoint)position withPlayer:(Captain *)Captain;
- (void)initialize;
-(SKSpriteNode*) createCaptain;
- (NSArray *)idleAnimationFrames;
- (NSArray *)walkAnimationFrames;
@end
