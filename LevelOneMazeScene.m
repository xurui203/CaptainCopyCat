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
//        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"practiceMazeMap.png"];
//        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//        background.name = @"background";
        
        SKSpriteNode *groundSprite = [self makeGround];
        groundSprite.position = CGPointMake(CGRectGetMidX(self.frame) - 150, CGRectGetMidY(self.frame) - 300);
        groundSprite.name = @"ground1";
        groundSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        groundSprite.physicsBody.dynamic = NO;
//        [self addChild:background];
        [self addChild:groundSprite];
        
        
    }
    return self;
}

-(SKSpriteNode *)makeGround
{
    SKSpriteNode * ground = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(500, 200)];
    return ground;
}

+ (void)loadSceneAssets {
    
    // Load archived emitters and create copyable sprites.

    // load background image
    
    // Load assets for all the sprites within this scene.


}
-(void)showCaptain {
          Captain *captain = [[Captain alloc]init];
//            captain.alpha= 1.0f;
        [self addChild:[captain createCaptain]];
    

}

-(void)startLevel {
    [self performSelector:@selector(showCaptain) withObject:Nil afterDelay:2.0];

}

@end
