//
//  Game.h
//  Example 2.0
//
//  Created by Robert Blackwood on 6/27/12.
//  Copyright Robert Blackwood 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "SpaceManagerCocos2d.h"

// HelloWorldLayer
@interface Game : CCLayer
{
    SpaceManagerCocos2d *_smgr;
}

// returns a CCScene that contains the Game as the only child
+(CCScene *) scene;

@end
