//
//  LevelOneMazeScene.m
//  CCC
//
//  Created by Ann Niou on 10/6/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import "LevelOneMazeScene.h"
#import "Captain.h"

@interface LevelOneMazeScene ()
//@property (nonatomic) NSTimeInterval lastUpdateTimeInterval; // the previous update: loop time interval
@property BOOL sceneCreated;
@property NSArray *walkAnimation;
@property (nonatomic,readwrite) Captain *captain;
@end


@implementation LevelOneMazeScene
{
    NSTimeInterval _currentTime;

}


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
        
        SKSpriteNode *ground1Sprite = [self makeGround1];
        SKSpriteNode *ground2Sprite = [self makeGround2];
        
        NSMutableArray *walkFrames = [NSMutableArray array];
        SKTextureAtlas *walkAtlas = [SKTextureAtlas atlasNamed:@"CCC_running"];
        
        for(int i =1; i<=walkAtlas.textureNames.count; ++i) {
            NSString *texture = [NSString stringWithFormat:@"ccc_%03d",i];
            
            [walkFrames addObject:[walkAtlas textureNamed:texture]];
        }
        self.walkAnimation = walkFrames;
//        [self addChild:background];
        [self addChild:ground1Sprite];
        [self addChild:ground2Sprite];
        
        
    }
    return self;
}



- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    if (self.captain != nil)
    {
        SKAction *animate = [SKAction
                             animateWithTextures:self.walkAnimation
                             timePerFrame: 0.05];
        [self.captain runAction:animate];
    }
}



-(SKSpriteNode *)makeGround1
{
    SKSpriteNode * groundSprite = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(300, 10)];
    groundSprite.position = CGPointMake(CGRectGetMidX(self.frame) - 150, CGRectGetMidY(self.frame) - 100);
    groundSprite.name = @"ground1";
    groundSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    groundSprite.physicsBody.dynamic = NO;
    return groundSprite;
}

-(SKSpriteNode *)makeGround2
{
    SKSpriteNode * groundSprite = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(150, 10)];
    groundSprite.position = CGPointMake(CGRectGetMidX(self.frame) + 200, CGRectGetMidY(self.frame) - 100);
    groundSprite.name = @"ground1";
    groundSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    groundSprite.physicsBody.dynamic = NO;
    return groundSprite;
}

+ (void)loadSceneAssets {
    
    // Load archived emitters and create copyable sprites.

    // load background image
    
    // Load assets for all the sprites within this scene.


}
-(void)showCaptain {
          self.captain = [[Captain alloc]init];
//            captain.alpha= 1.0f;
        [self addChild:[self.captain createCaptain]];
    

}

-(void)startLevel {
    [self performSelector:@selector(showCaptain) withObject:Nil afterDelay:2.0];

}



#pragma mark - Loop Update
- (void)update:(NSTimeInterval)currentTime {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = kMinTimeInterval;
        self.lastUpdateTimeInterval = currentTime;
//        self.worldMovedForUpdate = YES;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
        // heroMoveDirection is used by game controllers.
//        CGPoint captainMoveDirection = self.captain.;
//        if (hypotf(captainMoveDirection.x, captainMoveDirection.y) > 0.0f) {
//            [self.captain moveInDirection:captainMoveDirection withTimeInterval:timeSinceLast];
//        }
//        else {
    
            if (self.captain.moveLeft) {
                [self.captain move:CCCMoveDirectionLeft withTimeInterval:timeSinceLast];
            } else if (self.captain.moveRight) {
                [self.captain move:CCCMoveDirectionRight withTimeInterval:timeSinceLast];
            }
//        }

    }



#pragma mark - Loop Update
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    [self.captain updateWithTimeSinceLastUpdate:timeSinceLast];
    
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//}



//- (void)update:(NSTimeInterval)currentTime {
//    // Handle time delta.
//    // If we drop below 60fps, we still want everything to move the same distance.
//    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
//    self.lastUpdateTimeInterval = currentTime;
//    if (timeSinceLast > 1) { // more than a second since last update
//        timeSinceLast = 1.0 / 60.0;
//        self.lastUpdateTimeInterval = currentTime;
//    }
//    
////    [self updateWithTimeSinceLastUpdate:timeSinceLast];
//    
//}

@end
