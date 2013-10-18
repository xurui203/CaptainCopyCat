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
@property Captain *captain;
@property (nonatomic) SKNode *player;
@end


@implementation LevelOneMazeScene
{
    NSTimeInterval _currentTime;
    

}
@synthesize sequence;
@synthesize walkAnim;


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
        self.backgroundColor = [SKColor whiteColor];
        
        SKSpriteNode *ground1Sprite = [self makeGround1];
        SKSpriteNode *ground2Sprite = [self makeGround2];
        
        [self addChild:ground1Sprite];
        [self addChild:ground2Sprite];
        
        [self startLevel];
        
        //INITIALIZE A CAPTAIN
//        self.captain = [[Captain alloc]init];
//        self.captain.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//        [self addChild:[self.captain createCaptain]];
//
//        [self walkingCaptain];

    }
    return self;
}



//General method to make captain walk
-(void)walkingCaptain
{
    [self.captain runAction:[SKAction repeatActionForever:
                      [SKAction animateWithTextures:self.captain.walkAnimationFrames
                                       timePerFrame:0.1f
                                             resize:NO
                                            restore:YES]] withKey:@"walkingInPlaceCaptain"];
    return;
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

//INITIALIZE A CAPTAIN OBJECT
-(void)showCaptain {
          self.captain = [[Captain alloc]init];
        self.captain.position = CGPointMake(CGRectGetMidX(self.frame)-160,
                                        CGRectGetMidY(self.frame));
    [self addChild:[self.captain createCaptain]];
    
    //[self walkingCaptain];
    [self setUpActions];
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    
//    CGPoint location = [[touches anyObject] locationInNode:self];
//    CGFloat multiplierForDirection;
//    
//    if (location.x <= CGRectGetMidX(self.frame)) {
//        //walk left
//        multiplierForDirection = 1;
//        NSLog(@"walking left");
//    } else {
//        //walk right
//        multiplierForDirection = -1;
//        NSLog(@"walking right");
//
//    }
//    
//    self.captain.xScale = fabs(self.captain.xScale) * multiplierForDirection;
//    [self walkingCaptain];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    SKSpriteNode *captain = (SKSpriteNode*)[self childNodeWithName:@"captain"];
    [captain runAction:walkAnim];

}
-(void)update:(NSTimeInterval)currentTime {

    [self enumerateChildNodesWithName:@"captain" usingBlock:^(SKNode *node, BOOL *stop) {
        
        SKNode* captain = [self childNodeWithName:@"captain"];
        if ([captain isKindOfClass:[SKSpriteNode class]]) {
            SKSpriteNode *captain = (SKSpriteNode *)captain;

        };
        
    }];
}

-(void) setUpActions {
         SKAction *atlasAnim = [SKAction animateWithTextures:self.captain.walkAnimationFrames timePerFrame:.05];
         //SKAction *moveRight = [SKAction moveByX:50 y:0 duration:atlasAnim.duration];
    
//         SKAction *atlasAnim = [SKAction animateWithTextures:atlasTexture timePerFrame:.1];
          SKAction *moveRight = [SKAction moveByX:50 y:0 duration:.3];

         walkAnim = [SKAction group:@[atlasAnim,moveRight]];
    
        SKSpriteNode* captain = (SKSpriteNode*)[self childNodeWithName:@"captain"];
         [captain runAction:walkAnim];
     }

-(void)startLevel {
    [self performSelector:@selector(showCaptain) withObject:Nil afterDelay:2.0];

}


-(void)moveRight {
    NSLog(@"moveRight");
    SKAction *hover = [SKAction moveByX:100.0 y:0 duration:1.0];
    [self.captain runAction:hover];
    [self addChild:self.captain];
}

@end
