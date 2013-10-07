//
//  LevelOneMazeScene.m
//  CCC
//
//  Created by Ann Niou on 10/6/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import "LevelOneMazeScene.h"
#import "Captain.h"
@implementation LevelOneMazeScene


#pragma mark - Shared Assets
+ (void)loadSceneAssetsWithCompletionHandler:(APAAssetLoadCompletionHandler)handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // Load the shared assets in the background.
        [self loadSceneAssets];
        
        if (!handler) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Call the completion handler back on the main queue.
            handler();
        });
    });
}
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"practiceMazeMap.png"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        background.name = @"background";
        [self addChild:background];
        
        Captain *captain = [[Captain alloc]init];
        
        [self addChild:[captain createCaptain]];
        
    }
    return self;
}

//
//-(SKSpriteNode*) createCaptain {
//    Captain *captain = [Captain spriteNodeWithImageNamed:@"ccc_008"];
//    captain.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//    
//    
//}
+ (void)loadSceneAssets {
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"practiceMazeMap"];
    
    // Load archived emitters and create copyable sprites.

    // load background image
    
    // Load assets for all the sprites within this scene.


}



-(void)startLevel {
//    
//    Captain* captain = [[Captain alloc]init];
//    [captain createCaptain];
//    [captain initialize];

}

@end
