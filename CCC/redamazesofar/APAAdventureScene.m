/*
     File: APAAdventureScene.m
 Abstract: n/a
  Version: 1.2

 
 */

#import <SpriteKit/SpriteKit.h>
#import "APAAdventureScene.h"
#import "APAGraphicsUtilities.h"
#import "APACave.h"
#import "APAPlayer.h"

@interface APAAdventureScene () <SKPhysicsContactDelegate>

@property (nonatomic) APAPlayer *defaultPlayer;           // player '1' controlled by keyboard/touch

@property (nonatomic) APADataMapRef levelMap;             // locations of caves/spawn points/etc
@property (nonatomic) APATreeMapRef obstacleMap;              // locations of trees
@property (nonatomic) APACave *obstacles;
@property (nonatomic) NSMutableArray *parallaxSprites;    // all the parallax sprites in this scene
@end

@implementation APAAdventureScene
//@synthesize obstacles;

#pragma mark - Initialization and Deallocation
- (id)initWithSize:(CGSize)size {
    self = [self initWithSize:size];
    if (self) {
        _parallaxSprites = [[NSMutableArray alloc] init];
        _obstacles = [[SKNode alloc] init];
        
        // Build level and tree maps from map_collision.png and map_foliage.png respectively.
        _levelMap = APACreateDataMap(@"map_level.png");
        
        [self buildWorld];
                
        // Center the camera on the hero spawn point.
        CGPoint startPosition = self.defaultSpawnPoint;
        [self centerWorldOnPosition:startPosition];
    }
    return self;
}

- (void)dealloc {
    free(_levelMap);
    _levelMap = NULL;
}

#pragma mark - World Building
- (void)buildWorld {
    NSLog(@"Building the world");
    
    // Configure physics for the world.
    self.physicsWorld.gravity = CGVectorMake(0.0f, -9.8f); // downward gravity (I think)
    self.physicsWorld.contactDelegate = self;
    
    [self addBackgroundTiles];
    
    [self addObstacles];
    
    [self addCollisionWalls];
}

- (void)addBackgroundTiles {
    // Tiles should already have been pre-loaded in +loadSceneAssets.
    for (SKNode *tileNode in [self backgroundTiles]) {
        [self addNode:tileNode atWorldLayer:APAWorldLayerGround];
    }
}

- (void)addSpawnPoints {
    // set player spawn point
    for (int y = 0; y < kLevelMapSize; y++) {
        for (int x = 0; x < kLevelMapSize; x++) {
            CGPoint location = CGPointMake(x, y);
            APADataMap spot = [self queryLevelMap:location];
            
            // Get the world space point for this level map pixel.
            CGPoint worldPoint = [self convertLevelMapPointToWorldPoint:location];
            
            if (spot.heroSpawnLocation >= 200) {
                
                self.defaultSpawnPoint = worldPoint; // there's only one
            }
        }
    }
}

- (void)addCollisionWalls {
    NSDate *startDate = [NSDate date];
    unsigned char *filled = alloca(kLevelMapSize * kLevelMapSize);
    memset(filled, 0, kLevelMapSize * kLevelMapSize);
    
    int numVolumes = 0;
    int numBlocks = 0;
    
    // Add horizontal collision walls.
    for (int y = 0; y < kLevelMapSize; y++) { // iterate in horizontal rows
        for (int x = 0; x < kLevelMapSize; x++) {
            CGPoint location = CGPointMake(x, y);
            APADataMap spot = [self queryLevelMap:location];
            
            // Get the world space point for this pixel.
            CGPoint worldPoint = [self convertLevelMapPointToWorldPoint:location];
            
            if (spot.wall < 200) {
                continue; // no wall
            }
            
            int horizontalDistanceFromLeft = x;
            APADataMap nextSpot = spot;
            while (horizontalDistanceFromLeft < kLevelMapSize && nextSpot.wall >= 200 && !filled[(y * kLevelMapSize) + horizontalDistanceFromLeft]) {
                horizontalDistanceFromLeft++;
                nextSpot = [self queryLevelMap:CGPointMake(horizontalDistanceFromLeft, y)];
            }
            
            int wallWidth = (horizontalDistanceFromLeft - x);
            int verticalDistanceFromTop = y;
            
            if (wallWidth > 8) {
                nextSpot = spot;
                while (verticalDistanceFromTop < kLevelMapSize && nextSpot.wall >= 200) {
                    verticalDistanceFromTop++;
                    nextSpot = [self queryLevelMap:CGPointMake(x + (wallWidth / 2), verticalDistanceFromTop)];
                }
                
                int wallHeight = (verticalDistanceFromTop - y);
                for (int j = y; j < verticalDistanceFromTop; j++) {
                    for (int i = x; i < horizontalDistanceFromLeft; i++) {
                        filled[(j * kLevelMapSize) + i] = 255;
                        numBlocks++;
                    }
                }
                
                [self addCollisionWallAtWorldPoint:worldPoint withWidth:kLevelMapDivisor * wallWidth height:kLevelMapDivisor * wallHeight];
                numVolumes++;
            }
        }
    }
    
    // Add vertical collision walls.
    for (int x = 0; x < kLevelMapSize; x++) { // iterate in vertical rows
        for (int y = 0; y < kLevelMapSize; y++) {
            CGPoint location = CGPointMake(x, y);
            APADataMap spot = [self queryLevelMap:location];
            
            // Get the world space point for this pixel.
            CGPoint worldPoint = [self convertLevelMapPointToWorldPoint:location];
            
            if (spot.wall < 200 || filled[(y * kLevelMapSize) + x]) {
                continue; // no wall, or already filled from X collision walls
            }

            int verticalDistanceFromTop = y;
            APADataMap nextSpot = spot;
            while (verticalDistanceFromTop < kLevelMapSize && nextSpot.wall >= 200 && !filled[(verticalDistanceFromTop * kLevelMapSize) + x]) {
                verticalDistanceFromTop++;
                nextSpot = [self queryLevelMap:CGPointMake(x, verticalDistanceFromTop)];
            };
            
            int wallHeight = (verticalDistanceFromTop - y);
            int horizontalDistanceFromLeft = x;
            
            if (wallHeight > 8) {
                nextSpot = spot;
                while (horizontalDistanceFromLeft < kLevelMapSize && nextSpot.wall >= 200) {
                    horizontalDistanceFromLeft++;
                    nextSpot = [self queryLevelMap:CGPointMake(horizontalDistanceFromLeft, y + (wallHeight / 2))];
                };
                
                int wallLength = (horizontalDistanceFromLeft - x);
                for (int j = y; j < verticalDistanceFromTop; j++) {
                    for (int i = x; i < horizontalDistanceFromLeft; i++) {
                        filled[(j * kLevelMapSize) + i] = 255;
                        numBlocks++;
                    }
                }
                
                [self addCollisionWallAtWorldPoint:worldPoint withWidth:kLevelMapDivisor * wallLength height:kLevelMapDivisor * wallHeight];
                numVolumes++;
            }
        }
    }
    
    NSLog(@"converted %d collision blocks into %d volumes in %f seconds", numBlocks, numVolumes, [[NSDate date] timeIntervalSinceDate:startDate]);
}

- (void)addCollisionWallAtWorldPoint:(CGPoint)worldPoint withWidth:(CGFloat)width height:(CGFloat)height {
    CGRect rect = CGRectMake(0, 0, width, height);
    
    SKNode *wallNode = [SKNode node];
    wallNode.position = CGPointMake(worldPoint.x + rect.size.width * 0.5, worldPoint.y - rect.size.height * 0.5);
    wallNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rect.size];
    wallNode.physicsBody.dynamic = NO;
    wallNode.physicsBody.categoryBitMask = APAColliderTypeWall;
    wallNode.physicsBody.collisionBitMask = 0;
    
    [self addNode:wallNode atWorldLayer:APAWorldLayerGround];
}




#pragma mark - Level Start
- (void)startLevel {
    APAHeroCharacter *hero = [self addHeroForPlayer:self.defaultPlayer];
    
    [self centerWorldOnCharacter:hero];
}





// DIS WE GOTA CHANGE only 1 CCC 
#pragma mark - Heroes
- (void)setDefaultPlayerHeroType:(APAHeroType)heroType {
    switch (heroType) {
        case APAHeroTypeArcher:
            self.defaultPlayer.heroClass = [APAArcher class];
            break;
            
        case APAHeroTypeWarrior:
            self.defaultPlayer.heroClass = [APAWarrior class];
            break;
    }
}

// Run out of energy, rather?
- (void)heroWasKilled:(APAHeroCharacter *)hero {
    
    [super heroWasKilled:hero];
}

#pragma mark - Loop Update
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    // Update all players' heroes.
    for (APAHeroCharacter *hero in self.heroes) {
        [hero updateWithTimeSinceLastUpdate:timeSinceLast];
    }
}

- (void)didSimulatePhysics {
    [super didSimulatePhysics];
    
    // Get the position either of the default hero or the hero spawn point.
    APAHeroCharacter *defaultHero = self.defaultPlayer.hero;
    CGPoint position = CGPointZero;
    if (defaultHero && [self.heroes containsObject:defaultHero]) {
        position = defaultHero.position;
    } else {
        position = self.defaultSpawnPoint;
    }
    
    // Update the alphas of any trees that are near the hero (center of the camera) and therefore visible or soon to be visible.
    for (APATree *tree in self.trees) {
        if (APADistanceBetweenPoints(tree.position, position) < 1024) {
            [tree updateAlphaWithScene:self];
        }
    }
    
    if (!self.worldMovedForUpdate) {
        return;
    }
    
    // Show any nearby hidden particle systems and hide those that are too far away to be seen.
    for (SKEmitterNode *particles in self.particleSystems) {
        BOOL particlesAreVisible = APADistanceBetweenPoints(particles.position, position) < 1024;
        
        if (!particlesAreVisible && !particles.paused) {
            particles.paused = YES;
        } else if (particlesAreVisible && particles.paused) {
            particles.paused = NO;
        }
    }
    
    // Update nearby parallax sprites.
    for (APAParallaxSprite *sprite in self.parallaxSprites) {
        if (APADistanceBetweenPoints(sprite.position, position) >= 1024) {
            continue;
        };
        
        [sprite updateOffset];
    }
}

#pragma mark - Physics Delegate
- (void)didBeginContact:(SKPhysicsContact *)contact {
    // Either bodyA or bodyB in the collision could be a character.
    SKNode *node = contact.bodyA.node;
    if ([node isKindOfClass:[APACharacter class]]) {
        [(APACharacter *)node collidedWith:contact.bodyB];
    }
    
    // Check bodyB too.
    node = contact.bodyB.node;
    if ([node isKindOfClass:[APACharacter class]]) {
        [(APACharacter *)node collidedWith:contact.bodyA];
    }
    
    // Handle collisions with projectiles.
    if (contact.bodyA.categoryBitMask & APAColliderTypeProjectile || contact.bodyB.categoryBitMask & APAColliderTypeProjectile) {
        SKNode *projectile = (contact.bodyA.categoryBitMask & APAColliderTypeProjectile) ? contact.bodyA.node : contact.bodyB.node;

        [projectile runAction:[SKAction removeFromParent]];
        
        // Build up a "one shot" particle to indicate where the projectile hit.
        SKEmitterNode *emitter = [[self sharedProjectileSparkEmitter] copy];
        [self addNode:emitter atWorldLayer:APAWorldLayerAboveCharacter];
        emitter.position = projectile.position;
        APARunOneShotEmitter(emitter, 0.15f);
    }
}

#pragma mark - Mapping
- (APADataMap)queryLevelMap:(CGPoint)point {
    // Grab the level map pixel for a given x,y (upper left).
    return self.levelMap[((int)point.y) * kLevelMapSize + ((int)point.x)];
}

- (float)distanceToWall:(CGPoint)pos0 from:(CGPoint)pos1 {
    CGPoint a = [self convertWorldPointToLevelMapPoint:pos0];
    CGPoint b = [self convertWorldPointToLevelMapPoint:pos1];
    
    CGFloat deltaX = b.x - a.x;
    CGFloat deltaY = b.y - a.y;
    CGFloat dist = APADistanceBetweenPoints(a, b);
    CGFloat inc = 1.0 / dist;
    CGPoint p = CGPointZero;
    
    for (CGFloat i = 0; i <= 1; i += inc) {
        p.x = a.x + i * deltaX;
        p.y = a.y + i * deltaY;
        
        APADataMap point = [self queryLevelMap:p];
        if (point.wall > 200) {
            CGPoint wpos2 = [self convertLevelMapPointToWorldPoint:p];
            return APADistanceBetweenPoints(pos0, wpos2);
        }
    }
    return MAXFLOAT;
}

- (BOOL)canSee:(CGPoint)pos0 from:(CGPoint)pos1 {
    CGPoint a = [self convertWorldPointToLevelMapPoint:pos0];
    CGPoint b = [self convertWorldPointToLevelMapPoint:pos1];
    
    CGFloat deltaX = b.x - a.x;
    CGFloat deltaY = b.y - a.y;
    CGFloat dist = APADistanceBetweenPoints(a, b);
    CGFloat inc = 1.0 / dist;
    CGPoint p = CGPointZero;
    
    for (CGFloat i = 0; i <= 1; i += inc) {
        p.x = a.x + i * deltaX;
        p.y = a.y + i * deltaY;
        
        APADataMap point = [self queryLevelMap:p];
        if (point.wall > 200) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - Point Conversion
- (CGPoint)convertLevelMapPointToWorldPoint:(CGPoint)location {
    // Given a level map pixel point, convert up to a world point.
    // This determines which "tile" the point falls in and centers within that tile.
    int x =   (location.x * kLevelMapDivisor) - (kWorldCenter + (kWorldTileSize/2));
    int y = -((location.y * kLevelMapDivisor) - (kWorldCenter + (kWorldTileSize/2)));
    return CGPointMake(x, y);
}

- (CGPoint)convertWorldPointToLevelMapPoint:(CGPoint)location {
    // Given a world based point, resolve to a pixel location in the level map.
    int x = (location.x + kWorldCenter) / kLevelMapDivisor;
    int y = (kWorldSize - (location.y + kWorldCenter)) / kLevelMapDivisor;
    return CGPointMake(x, y);
}

#pragma mark - Shared Assets
+ (void)loadSceneAssets {
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Environment"];

    // Load archived emitters and create copyable sprites.
    sSharedProjectileSparkEmitter = [SKEmitterNode apa_emitterNodeWithEmitterNamed:@"ProjectileSplat"];
    sSharedSpawnEmitter = [SKEmitterNode apa_emitterNodeWithEmitterNamed:@"Spawn"];
    
    // Load the tiles that make up the ground layer.
    [self loadWorldTiles];
    
    // Load assets for all the sprites within this scene.
    [APACave loadSharedAssets];
    [APAArcher loadSharedAssets];
    [APAWarrior loadSharedAssets];
    [APAGoblin loadSharedAssets];
    [APABoss loadSharedAssets];
}

+ (void)loadWorldTiles {
    NSLog(@"Loading world tiles");
    NSDate *startDate = [NSDate date];
    
    SKTextureAtlas *tileAtlas = [SKTextureAtlas atlasNamed:@"Tiles"];
    
    sBackgroundTiles = [[NSMutableArray alloc] initWithCapacity:1024];
    for (int y = 0; y < kWorldTileDivisor; y++) {
        for (int x = 0; x < kWorldTileDivisor; x++) {
            int tileNumber = (y * kWorldTileDivisor) + x;
            SKSpriteNode *tileNode = [SKSpriteNode spriteNodeWithTexture:[tileAtlas textureNamed:[NSString stringWithFormat:@"tile%d.png", tileNumber]]];
            CGPoint position = CGPointMake((x * kWorldTileSize) - kWorldCenter,
                                           (kWorldSize - (y * kWorldTileSize)) - kWorldCenter);
            tileNode.position = position;
            tileNode.zPosition = -1.0f;
            tileNode.blendMode = SKBlendModeReplace;
            [(NSMutableArray *)sBackgroundTiles addObject:tileNode];
        }
    }
    NSLog(@"Loaded all world tiles in %f seconds", [[NSDate date] timeIntervalSinceDate:startDate]);
}

+ (void)releaseSceneAssets {
    // Get rid of everything unique to this scene (but not the characters, which might appear in other scenes).
    sBackgroundTiles = nil;
    sSharedProjectileSparkEmitter = nil;
    sSharedSpawnEmitter = nil;
    sSharedLeafEmitterA = nil;
    sSharedLeafEmitterB = nil;
}

static SKEmitterNode *sSharedProjectileSparkEmitter = nil;
- (SKEmitterNode *)sharedProjectileSparkEmitter {
    return sSharedProjectileSparkEmitter;
}

static SKEmitterNode *sSharedSpawnEmitter = nil;
- (SKEmitterNode *)sharedSpawnEmitter {
    return sSharedSpawnEmitter;
}

static NSArray *sBackgroundTiles = nil;
- (NSArray *)backgroundTiles {
    return sBackgroundTiles;
}

@end
