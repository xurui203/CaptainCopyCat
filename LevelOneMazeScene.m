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
@property (nonatomic) Captain *captain;
@property (nonatomic, strong) NSArray *walkFramesRight;
@property (nonatomic) SKNode *player;
@end


@implementation LevelOneMazeScene
{
    NSTimeInterval _currentTime;
    

}
@synthesize sequence;
@synthesize walkAnim;

//-(SKAction *)walkRight {
//    if (_walkRight == nil) {
//        self.walkFramesRight = [[self class] animationFramesForImageNamePrefix:@"MSWWalkRight-" frameCount:kDefaultNumberOfWalkFrames];
//        _animateManWalkingRight = [SKAction animateWithTextures:self.walkFramesRight timePerFrame:kShowCharacterFramesOverOneSecond resize:YES restore:NO];
//    }
//    
//    return _animateManWalkingRight;
//}
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

//        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"practiceMazeMap.png"];
//        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//        background.name = @"background";
//        SKAction *walk = [SKAction animateWithTextures:CAPTAIN_ANIM_CCC timePerFrame:0.033];
//
////        SKAction *resetDirection   = [SKAction scaleXTo:1  y:1 duration:0.0];
//        SKAction *walkAnim = [SKAction sequence:@[walk, walk, walk, walk, walk, walk]];
////    SKAction *moveRight  = [SKAction moveToX:900 duration:walkAnim.duration];
//        SKAction *moveRight = [SKAction moveByX:100 y:0 duration:walkAnim.duration];
//        SKAction *walkAndMoveRight = [SKAction group:@[walkAnim, moveRight]];
//        SKAction *remove = [SKAction removeFromParent];
        
        SKSpriteNode *ground1Sprite = [self makeGround1];
        SKSpriteNode *ground2Sprite = [self makeGround2];
        
//        NSMutableArray *walkFrames = [NSMutableArray array];
        
//        self.walkAnimation = walkFrames;
//        [self addChild:background];
        [self addChild:ground1Sprite];
        [self addChild:ground2Sprite];
        
        [self startLevel];
//        self.sequence = [SKAction repeatActionForever:[SKAction sequence:@[remove, walkAndMoveRight]]];

    }
    return self;
}


//- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    // each time the user touches the screen, we create a new sprite, set its position, ...
////    self.captain = [Captain spriteNodeWithTexture:CAPTAIN_TEX_CCC_005 size:CGSizeMake(100, 1)];
////    captainWalking.position = self.captain.position;
//    
//    // ... attach the action with the walk animation, and add it to our scene
//    self.captain.position =CGPointMake(20,130);
//
//    [self.captain runAction:sequence];
//    [self addChild:self.captain];
//
//    //CGPoint location = [self.captain position];
//    
////    SKSpriteNode *captainCC = [SKSpriteNode spriteNodeWithImageNamed:@"ccc_008.png"];
////    captainCC.position = CGPointMake(20,130);
////    captainCC.zPosition=1;
////    captainCC.scale = 0.5;
////    SKAction *action = [SKAction moveToX:self.frame.size.height-100 duration:3];
////    SKAction *remove = [SKAction removeFromParent];
////    [self.captain runAction:[SKAction sequence:@[action,remove]]];
////    [self addChild:captainCC];
//    
////    if (self.captain != nil)
////    {
////        SKAction *animate = [SKAction
////                             animateWithTextures:self.walkAnimation
////                             timePerFrame: 0.05];
////        [self.captain runAction:animate];
////    }
////    

////    }
//}
//


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
//            captain.alpha= 1.0f;
        [self addChild:[self.captain createCaptain]];
    
    [self setUpActions];
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
         SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"CCC_running"];
                  SKTexture *run2 = [atlas textureNamed:@"ccc_002"];
         SKTexture *run3 = [atlas textureNamed:@"ccc_003"];
         SKTexture *run4 = [atlas textureNamed:@"ccc_004"];
         SKTexture *run5 = [atlas textureNamed:@"ccc_005"];
         SKTexture *run6 = [atlas textureNamed:@"ccc_006"];
         SKTexture *run7 = [atlas textureNamed:@"ccc_007"];
         SKTexture *run8 = [atlas textureNamed:@"ccc_008"];
         SKTexture *run9 = [atlas textureNamed:@"ccc_009"];
         SKTexture *run10 = [atlas textureNamed:@"ccc_010"];
         SKTexture *run11= [atlas textureNamed:@"ccc_011"];
         SKTexture *run12= [atlas textureNamed:@"ccc_012"];
         NSArray *atlasTexture = @[run2,run3,run4,run5,run6,run7,run8,run9,run10,run11,run12];

         SKAction *atlasAnim = [SKAction animateWithTextures:atlasTexture timePerFrame:.05];
         SKAction *moveRight = [SKAction moveByX:50 y:0 duration:atlasAnim.duration];

//         SKAction *atlasAnim = [SKAction animateWithTextures:atlasTexture timePerFrame:.1];
//         SKAction *moveRight = [SKAction moveByX:50 y:0 duration:.3];


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
