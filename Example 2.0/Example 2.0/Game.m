//
//  Game.m
//  Example 2.0
//
//  Created by Robert Blackwood on 6/27/12.
//  Copyright Robert Blackwood 2012. All rights reserved.
//


// Import the interfaces
#import "Game.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

// Functions to help with different screen sizes
#import "ScreenUtils.h"

#pragma mark - Game

// HelloWorldLayer implementation
@implementation Game

// Helper class method that creates a Scene with the Game as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Game *layer = [Game node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
        // Initialize
        _smgr = [[SpaceManagerCocos2d spaceManager] retain];
                
        // Set the world-to-physics-ratio for the coordinates
        // Only need to do this once (AppDelegate would be a better place)
        // and this will basically make the ipad's coordinate system roughly
        // equal to the iphones (480pts x 360pts)
        cpCCNodeImpl.xScaleRatio = DEVICE_X_RATIO;
        cpCCNodeImpl.yScaleRatio = DEVICE_X_RATIO;
        
        // Create a world boundary
        [_smgr addWindowContainmentWithFriction:1.0 
                                     elasticity:0.8 
                                           size:CGSizeMake(480, (isIpad() ? 360 : 320)) 
                                          inset:cpv(-2,-2) 
                                         radius:3];
        _smgr.cleanupBodyDependencies = YES;
        
        cpCCSprite *icon = [cpCCSprite spriteWithFile:@"Icon.png"];
        icon.shape = [_smgr addRectAt:cpv(240, 160) 
                                 mass:200 
                                width:57 
                               height:57 
                             rotation:-CC_DEGREES_TO_RADIANS(30)];
        [self addChild:icon];
        
        cpShapeNode *circle = [cpShapeNode nodeWithShape:[_smgr addCircleAt:cpv(240, 190) 
                                                                       mass:200 
                                                                     radius:15]];
        circle.color = ccYELLOW;
        [self addChild:circle];
        
        cpShapeNode *square = [cpShapeNode nodeWithShape:[_smgr addRectAt:cpv(240, 130) 
                                                                     mass:200 
                                                                    width:25 
                                                                   height:25 
                                                                 rotation:-CC_DEGREES_TO_RADIANS(-10)]];
        square.color = ccORANGE;
        square.opacity = 200;
        [self addChild:square];
        
        
        cpShapeNode *square2 = [cpShapeNode nodeWithShape:[_smgr addRectAt:cpv(280, 130) 
                                                        mass:200 
                                                       width:25 
                                                      height:25 
                                                    rotation:-CC_DEGREES_TO_RADIANS(-10)]];
        square2.color = ccGREEN;
        square2.spaceManager = _smgr;
        square2.autoFreeShapeAndBody = YES;
        [self addChild:square2];
        
        //[self removeChild:square2 cleanup:YES];
        
        [_smgr addGearToBody:square.body fromBody:square2.body ratio:0.5f];
        [_smgr addMotorToBody:square.body rate:1];
        [_smgr addSlideToBody:square2.body fromBody:_smgr.staticBody toBodyAnchor:cpvzero fromBodyAnchor:cpv(280,320) minLength:1 maxLength:260];
        
        cpShapeTextureNode *textured = [cpShapeTextureNode nodeWithShape:[_smgr addCircleAt:cpv(300, 190) 
                                                                                       mass:200 
                                                                                     radius:55] file:@"texture.png"];
        [self addChild:textured];
        
        [_smgr addPulleyToBody:textured.body fromBody:circle.body toBodyAnchor:cpvzero fromBodyAnchor:cpvzero toPulleyWorldAnchor:cpv(200, 320) fromPulleyWorldAnchor:cpv(400, 320) ratio:1];
        
        
        cpConstraintNode *spring = [cpConstraintNode nodeWithConstraint:[_smgr addSpringToBody:icon.body 
                                                                                      fromBody:_smgr.staticBody 
                                                                                  toBodyAnchor:cpvzero 
                                                                                fromBodyAnchor:cpv(290,170) 
                                                                                    restLength:60 
                                                                                     stiffness:700 
                                                                                       damping:.97]];
        spring.color = ccORANGE;
        [self addChild:spring];
        
        
        [self addChild:[_smgr createDebugLayer]];
        
        cpShape *c = [_smgr addCircleAt:cpv(100, 210) mass:50 radius:10];
        [_smgr addPivotToBody:c->body fromBody:_smgr.staticBody worldAnchor:c->body->p];
        [_smgr addMotorToBody:c->body fromBody:_smgr.staticBody rate:1];
        
        cpShape *d = [_smgr addRectAt:cpv(100, 240) mass:10 width:10 height:20 rotation:0];
        [_smgr addPivotToBody:d->body fromBody:c->body worldAnchor:cpvadd(d->body->p, cpv(0,-8))];
        [_smgr addRotaryLimitToBody:d->body fromBody:c->body min:-.05 max:0.5];
                
        [_smgr start];
        
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    // Remove children before spacemanager to avoid clashing with spacemanager
    // and the autoFreeBodyAndShape property
    [self removeAllChildrenWithCleanup:YES];

    // Release the spacemanager
    [_smgr release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
