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
- (id)initWithTexture:(SKTexture *)texture atPosition:(CGPoint)position withPlayer:(Captain *)Captain;
- (id)initAtPosition:(CGPoint)position withPlayer:(Captain *)Captain;


- (NSArray *)idleAnimationFrames;
- (NSArray *)walkAnimationFrames;
@end
