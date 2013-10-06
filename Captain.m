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
- (id)initAtPosition:(CGPoint)position withPlayer:(Captain *)Captain {
    return [self initWithTexture:nil atPosition:position withPlayer:Captain];
}

- (id)initWithTexture:(SKTexture *)texture atPosition:(CGPoint)position withPlayer:(Captain *)Captain {
    self = [self initWithTexture:texture atPosition:position];
    if (self) {
        _Captain = Captain;
        
        // Rotate by PI radians (180 degrees) so hero faces down rather than toward wall at start of game.
        self.zRotation = M_PI;
        self.zPosition = -0.25;
        self.name = [NSString stringWithFormat:@"Hero"];
    }
    
    return self;
}


- (NSArray *)idleAnimationFrames {
    return nil;
}

- (NSArray *)walkAnimationFrames {
    return nil;
}



@end
