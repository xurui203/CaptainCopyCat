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
    }
    return self;
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

//General method to make captain walk
-(void)walkingCaptain
{
    SKSpriteNode *captain = (SKSpriteNode*)[self childNodeWithName:@"captain"];

    [captain runAction:[SKAction repeatActionForever:
                             [SKAction animateWithTextures:self.captain.walkAnimationFrames
                                              timePerFrame:0.1f
                                                    resize:NO
                                                   restore:YES]] withKey:@"walkingInPlaceCaptain"];
    NSLog(@"Captain walking");
    return;
}

//INITIALIZE A CAPTAIN OBJECT
-(void)initializeCaptain {
    self.captain = [[Captain alloc]init];
    self.captain.position = CGPointMake(CGRectGetMidX(self.frame)-150,
                                        CGRectGetMidY(self.frame)-70);
    [self addChild:self.captain.createCaptain];
    [self setUpActions];
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    NSLog(@"Touches ended");
    [self walkingCaptain];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    SKSpriteNode *captain = (SKSpriteNode*)[self childNodeWithName:@"captain"];
    [captain runAction:walkAnim];
    NSLog(@"Touches began");

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
        SKAction *moveRight = [SKAction moveByX:40 y:0 duration:.3];
        walkAnim = [SKAction group:@[atlasAnim,moveRight]];

     }

-(void)startLevel {
    [self performSelector:@selector(initializeCaptain) withObject:Nil afterDelay:2.0];

}


-(void)moveRight {
    NSLog(@"moveRight");
    SKAction *hover = [SKAction moveByX:100.0 y:0 duration:1.0];
    [self.captain runAction:hover];
    [self addChild:self.captain];
}

@end
