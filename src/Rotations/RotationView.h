//
//  RotationView.h
//  Rotations
//
//  Created by Martin Ellern Bilgrau on 22/04/15.
//
//

#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

#import <UIKit/UIKit.h>

@interface RotationView : UIView

typedef NS_ENUM(NSInteger, ColorTypes) {
    Green = 1,
    Blue = 2,
    Red = 3
};

@property (nonatomic) NSInteger Left;
@property (nonatomic) NSInteger Middle;
@property (nonatomic) NSInteger Right;

- (void)rotate;
- (void)flipUpDown;
- (void)flipLeftRight;

@end
