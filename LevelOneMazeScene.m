//
//  LevelOneMazeScene.m
//  CCC
//
//  Created by Ann Niou on 10/6/13.
//  Copyright (c) 2013 Ann Niou. All rights reserved.
//

#import "LevelOneMazeScene.h"
#import "Captain.h"
#import "JSTileMap.h"
#import "LFCGzipUtility.h"

@interface LevelOneMazeScene ()
//@property (nonatomic) NSTimeInterval lastUpdateTimeInterval; // the previous update: loop time interval
@property BOOL sceneCreated;
@property Captain *captain;
@property (nonatomic) SKNode *player;
@property (nonatomic) JSTileMap *tiledMap;
@end


@implementation LevelOneMazeScene
{
    NSTimeInterval _currentTime;
    

}
@synthesize sequence;
@synthesize walkAnim;
@synthesize tiledMap;
@synthesize captain;

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
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8f);
        self.physicsWorld.contactDelegate = self;
        
        // FAKE GROUND FOR TESTING PURPOSES
        SKSpriteNode *pseudoGround = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(500,20)];
        pseudoGround.position = CGPointMake(CGRectGetMidX(self.frame) - 150,                              CGRectGetMidY(self.frame)-110);
        pseudoGround.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pseudoGround.size];
        pseudoGround.physicsBody.dynamic = NO;
        [self addChild:pseudoGround];
        
        
        tiledMap = [JSTileMap mapNamed:@"level1.tmx"];
        if (tiledMap){
            [self addChild:tiledMap];
        }
        tiledMap.zPosition = 0;
        captain = [[Captain alloc]init];
        SKTexture *temp = captain.walkAnimationFrames[0];
        captain = [Captain spriteNodeWithTexture:temp];
        
        
      //  captain.position = CGPointMake(100, 170);
        
        self.captain.position = CGPointMake(CGRectGetMidX(self.frame)-150,
                                              CGRectGetMidY(self.frame) - 10);
        captain.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(60, 80)];
        captain.physicsBody.mass = 50.0f;
        captain.physicsBody.dynamic = YES;
        captain.physicsBody.usesPreciseCollisionDetection = YES;
        
        captain.name = @"captain";
        [tiledMap addChild:captain];
        captain.zPosition = 15;
//        SKSpriteNode *ground1Sprite = [self makeGround1];
//        SKSpriteNode *ground2Sprite = [self makeGround2];
//        
//        [self addChild:ground1Sprite];
//        [self addChild:ground2Sprite];
//        
//        [self startLevel];
            [self setUpActions];
      
    }
    return self;
}


- (void)didSimulatePhysics
{
    [self centerOnNode: [self childNodeWithName: @"//camera"]];
}

- (void) centerOnNode: (SKNode *) node
{
    CGPoint cameraPositionInScene = [node.scene convertPoint:node.position fromNode:node.parent];
    node.parent.position = CGPointMake(node.parent.position.x - cameraPositionInScene.x,                                       node.parent.position.y - cameraPositionInScene.y);
}

+ (void)loadSceneAssets {
    
    // Load archived emitters and create copyable sprites.

    // load background image
    
    // Load assets for all the sprites within this scene.


}

//General method to make captain walk
-(void)walkingCaptain
{
//    SKSpriteNode *captain = (SKSpriteNode*)[self childNodeWithName:@"captain"];

    [captain runAction:[SKAction repeatActionForever:
                             [SKAction animateWithTextures:self.captain.walkAnimationFrames
                                              timePerFrame:0.1f
                                                    resize:NO
                                                   restore:YES]] withKey:@"walkingInPlaceCaptain"];
    NSLog(@"Captain walking");
    return;
}

//INITIALIZE A CAPTAIN OBJECT
//-(Captain*)initializeCaptain {
//    
//    captain = [[Captain alloc]init];
////    self.captain = [[Captain alloc]init];
//    self.captain.position = CGPointMake(CGRectGetMidX(self.frame)-150,
//                                        CGRectGetMidY(self.frame)-70);
////    [self addChild:self.captain.createCaptain];
//    captain = captain.createCaptain;
//    
//    [self setUpActions];
//    return captain;
//}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    captain.forwardMarch = NO;
    for (UITouch *t in touches) {
        UITouch * touch = [touches anyObject];
        CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
        NSLog(@"Position of touch: %.3f, %.3f", pos.x, pos.y);
        
        if (pos.x < 140) {
            captain.forwardMarch = NO;
        } else {
            captain.mightAsWellJump = NO;
        }
    }

    NSLog(@"Touches ended");
//    [self walkingCaptain];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

//    SKSpriteNode *captain = (SKSpriteNode*)[self childNodeWithName:@"captain"];
//    [captain runAction:walkAnim];
//    NSLog(@"Touches began");
    
    
    for (UITouch *t in touches) {
        
        UITouch * touch = [touches anyObject];
        CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
        NSLog(@"Position of touch: %.3f, %.3f", pos.x, pos.y);
        
        //        if (pos.x > 140) {
        ////            captain.mightAsWellJump = YES;
        //        } else {
        //            captain.forwardMarch = YES;
        //
        //
        //        }
        
        if (pos.x >140) {
            captain.forwardMarch = YES;
        }
    }
    
    

}
-(void)update:(NSTimeInterval)currentTime {

    [self enumerateChildNodesWithName:@"captain" usingBlock:^(SKNode *node, BOOL *stop) {
        
        SKNode* captain = [self childNodeWithName:@"captain"];
        if ([captain isKindOfClass:[SKSpriteNode class]]) {
            SKSpriteNode *captain = (SKSpriteNode *)captain;

        };
        
    }];
    if (captain.forwardMarch) {
        [captain runAction:walkAnim];

    }
    
    [self setViewpointCenter:captain.position];

}

-(void)setViewpointCenter:(CGPoint) position {
    
    CGSize winSize = self.view.frame.size;
    
    int x = MAX(position.x, winSize.width / 2);
    int y = MAX(position.y, winSize.height / 2);
    x = MIN(x, (tiledMap.mapSize.width * tiledMap.tileSize.width)
            - winSize.width / 2);
    y = MIN(y, (tiledMap.mapSize.height * tiledMap.tileSize.height)
            - winSize.height/2);
    CGPoint actualPosition = CGPointMake(x, y);
    
    CGPoint centerOfView = CGPointMake(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = CGPointMake(centerOfView.x-actualPosition.x, centerOfView.y-actualPosition.y);
    tiledMap.position = viewPoint;
}


-(void) setUpActions {
        SKAction *atlasAnim = [SKAction animateWithTextures:captain.walkAnimationFrames timePerFrame:.05];
        SKAction *moveRight = [SKAction moveByX:40 y:0 duration:.3];

//        SKAction *jumpUp = [SKAction moveByX:0 y:50 duration:.3];
    
        walkAnim = [SKAction group:@[atlasAnim,moveRight]];

     }

//-(void)startLevel {
//    [self performSelector:@selector(initializeCaptain) withObject:Nil afterDelay:2.0];
//
//}


-(void)moveRight {
    NSLog(@"moveRight");
    SKAction *hover = [SKAction moveByX:100.0 y:0 duration:1.0];
    [captain runAction:hover];
//    [self addChild:captain];
}


//
//-(SKSpriteNode *)makeGround1
//{
//    SKSpriteNode * groundSprite = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(300, 10)];
//    groundSprite.position = CGPointMake(CGRectGetMidX(self.frame) - 150, CGRectGetMidY(self.frame) - 100);
//    groundSprite.name = @"ground1";
//    groundSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
//    groundSprite.physicsBody.dynamic = NO;
//    return groundSprite;
//}
//
//-(SKSpriteNode *)makeGround2
//{
//    SKSpriteNode * groundSprite = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(150, 10)];
//    groundSprite.position = CGPointMake(CGRectGetMidX(self.frame) + 200, CGRectGetMidY(self.frame) - 100);
//    groundSprite.name = @"ground1";
//    groundSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
//    groundSprite.physicsBody.dynamic = NO;
//    return groundSprite;
//}

@end
