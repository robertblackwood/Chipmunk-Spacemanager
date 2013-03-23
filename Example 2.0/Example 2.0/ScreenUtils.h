//
//  ScreenUtils.h
//  SpaceManager
//
//  Created by Robert Blackwood on 2/11/12.
//

////// Context sensitive positioning (phone vs pad)
#define isIpad()                (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IPAD_2_IPHONE_X_RATIO   2.13333
#define IPAD_2_IPHONE_Y_RATIO   2.4

#define DEVICE_X_RATIO (isIpad() ? IPAD_2_IPHONE_X_RATIO : 1)
#define DEVICE_Y_RATIO (isIpad() ? IPAD_2_IPHONE_Y_RATIO : 1)

// Convert a single value
#define phone2padX(x)            ((x)*IPAD_2_IPHONE_X_RATIO)
#define pad2phoneX(x)            ((x)/IPAD_2_IPHONE_X_RATIO)
//
#define phone2padY(y)            ((y)*IPAD_2_IPHONE_Y_RATIO)
#define pad2phoneY(y)            ((y)/IPAD_2_IPHONE_Y_RATIO)

#define valX(x)                 (isIpad() ? phone2padX(x) : x)
#define valRX(x)                (isIpad() ? pad2phoneX(x) : x)
//
#define valY(y)                 (isIpad() ? phone2padY(y) : y)
#define valRY(y)                (isIpad() ? pad2phoneY(y) : y)

#define CGRectMakeXY(x1,y1,x2,y2)   CGRectMake(valX(x1),valY(y1),valX(x2),valY(y2))
#define CGPointMakeXY(x,y)          CGPointMake(valX(x),valY(y))

#define ccpXY(x,y)                  CGPointMakeXY(x,y)
#define ccpX(x,y)                   ccp(valX(x), valX(y))
#define ccpY(x,y)                   ccp(valY(x), valY(y))

#define ccpRX(x,y)                   ccp(valRX(x), valRX(y))
#define ccpRY(x,y)                   ccp(valRY(x), valRY(y))

static inline CGPoint ccpXpt(CGPoint pt)
{
    return ccp(valX(pt.x), valX(pt.y));
}

static inline CGPoint ccpRXpt(CGPoint pt)
{
    return ccp(valRX(pt.x), valRX(pt.y));
}

static inline CGPoint ccpYpt(CGPoint pt)
{
    return ccp(valY(pt.x), valY(pt.y));
}

static inline CGPoint ccpRYpt(CGPoint pt)
{
    return ccp(valRY(pt.x), valRY(pt.y));
}

static inline CGPoint ccpXYpt(CGPoint pt)
{
    return ccp(valX(pt.x), valY(pt.y));
}

static inline CGPoint ccpRXYpt(CGPoint pt)
{
    return ccp(valRX(pt.x), valRY(pt.y));
}