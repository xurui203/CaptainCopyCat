//
//  Superpower.m
//  CCC
//
//  Created by Xu Rui on 25/10/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import "Superpower.h"
#import <UIKit/UIKit.h>

@interface Superpower ()
@property (nonatomic, strong) NSArray *transformationFrames;
@end


@implementation Superpower


- (NSArray *)transformAnimationFrames {
    
    NSMutableArray *transformFrames = [NSMutableArray array];
    SKTextureAtlas *kangarooTransformationAtlas = [SKTextureAtlas atlasNamed:@"Kangaroo_transform"];
    NSString *textureName = [NSString stringWithFormat:@"kangaroo_standing"];
    SKTexture *stand = [kangarooTransformationAtlas textureNamed:textureName];
    [transformFrames addObject:stand];
    return transformFrames;
}



@end
