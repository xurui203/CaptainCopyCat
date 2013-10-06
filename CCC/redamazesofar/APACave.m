/*
     File: APACave.m
 Abstract: n/a
  Version: 1.2
 
 
 Copyright (C) 2013 Apple Inc. All Rights Reserved.
 
 */

#import "APACave.h"
#import "APAGraphicsUtilities.h"
#import "APAParallaxSprite.h"

#define kCaveCollisionRadius 90
#define kCaveCapacity 50


@interface APACave ()
@property (nonatomic) NSMutableArray *activeGoblins;
@property (nonatomic) NSMutableArray *inactiveGoblins;
@property (nonatomic) SKEmitterNode *smokeEmitter;
@end

@implementation APACave

#pragma mark - Initialization
- (id)initAtPosition:(CGPoint)position {
    self = [super initWithSprites:@[ [[self caveBase] copy], [[self caveTop] copy]] atPosition:position usingOffset:50.0f];
    
    if (self) {
        _timeUntilNextGenerate = 5.0f + (APA_RANDOM_0_1() * 5.0f);
        
        _activeGoblins = [[NSMutableArray alloc] init];
        _inactiveGoblins = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < kCaveCapacity; i++) {
            APAGoblin *goblin = [[APAGoblin alloc] initAtPosition:self.position];
            goblin.cave = self;
            [(NSMutableArray *)_inactiveGoblins addObject:goblin];
        }
        
        self.movementSpeed = 0.0f;

        [self pickRandomFacingForPosition:position];
        
        self.name = @"GoblinCave";
        
        // Make it AWARE!
        self.intelligence = [[APASpawnAI alloc] initWithCharacter:self target:nil];
    }
    
    return self;
}

- (void)pickRandomFacingForPosition:(CGPoint)position {
    APAMultiplayerLayeredCharacterScene *scene = [self characterScene];
    
    // Pick best random facing from 8 test rays.
    CGFloat maxDoorCanSee = 0.0;
    CGFloat preferredZRotation = 0.0;
    for (int i = 0; i < 8; i++) {
        CGFloat testZ = APA_RANDOM_0_1() * (M_PI * 2.0f);
        CGPoint pos2 = CGPointMake( -sinf(testZ)*1024 + position.x , cosf(testZ)*1024 + position.y );
        CGFloat dist = [scene distanceToWall:position from:pos2];
        if (dist > maxDoorCanSee) {
            maxDoorCanSee = dist;
            preferredZRotation = testZ;
        }
    }
    self.zRotation = preferredZRotation;
}

#pragma mark - Overridden Methods
- (void)configurePhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:kCaveCollisionRadius];
    self.physicsBody.dynamic = NO;
    
    self.animated = NO;
    self.zPosition = -0.85;
    
    // Our object type for collisions.
    self.physicsBody.categoryBitMask = APAColliderTypeCave;
    
    // Collides with these objects.
    self.physicsBody.collisionBitMask = APAColliderTypeProjectile | APAColliderTypeHero;
    
    // We want notifications for colliding with these objects.
    self.physicsBody.contactTestBitMask = APAColliderTypeProjectile;
}

- (void)reset {
    [super reset];
    
    self.animated = NO;
}

- (void)collidedWith:(SKPhysicsBody *)other {
    if (self.health > 0.0f) {
        if (other.categoryBitMask & APAColliderTypeProjectile) {
            CGFloat damage = 10.0f;
            BOOL killed = [self applyDamage:damage fromProjectile:other.node];
            if (killed) {
                [[self characterScene] addToScore:25 afterEnemyKillWithProjectile:other.node];
            }
        }
    }
}

#pragma mark - Loop Update
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)interval {
    [super updateWithTimeSinceLastUpdate:interval]; // this will update the SpawnAI
    
    // Update our goblins.
    for (APAGoblin *goblin in self.activeGoblins) {
        [goblin updateWithTimeSinceLastUpdate:interval];
    }
}



- (void)recycle:(APAGoblin *)goblin {
    [goblin reset];
    [(NSMutableArray *)self.activeGoblins removeObject:goblin];
    [(NSMutableArray *)self.inactiveGoblins addObject:goblin];
    
    sGlobalAllocation--;
}

#pragma mark - Shared Resources
+ (void)loadSharedAssets {
    [super loadSharedAssets];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Environment"];

        SKEmitterNode *fire = [SKEmitterNode apa_emitterNodeWithEmitterNamed:@"CaveFire"];
        fire.zPosition = 1;
        
        SKEmitterNode *smoke = [SKEmitterNode apa_emitterNodeWithEmitterNamed:@"CaveFireSmoke"];
        
        SKNode *torch = [[SKNode alloc] init];
        [torch addChild:fire];
        [torch addChild:smoke];
        
        sSharedCaveBase = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"cave_base.png"]];
        
        // Add two torches either side of the entrance.
        torch.position = CGPointMake(83, 83);
        [sSharedCaveBase addChild:torch];
        SKNode *torchB = [torch copy];
        torchB.position = CGPointMake(-83, 83);
        [sSharedCaveBase addChild:torchB];
        
        sSharedCaveTop = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"cave_top.png"]];
        
        sSharedDeathSplort = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"cave_destroyed.png"]];
        
        sSharedDamageEmitter = [SKEmitterNode apa_emitterNodeWithEmitterNamed:@"CaveDamage"];
        sSharedDeathEmitter = [SKEmitterNode apa_emitterNodeWithEmitterNamed:@"CaveDeathSmoke"];
        
        sSharedDamageAction = [SKAction sequence:@[
                                                   [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:1.0 duration:0.0],
                                                   [SKAction waitForDuration:0.25],
                                                   [SKAction colorizeWithColorBlendFactor:0.0 duration:0.1],
                                                   ]];
    });
}


@end
