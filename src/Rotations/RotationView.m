//
//  RotationView.m
//  Rotations
//
//  Created by Martin Ellern Bilgrau on 22/04/15.
//
//

#import "RotationView.h"

@interface RotationView ()

@property(nonatomic, strong, readwrite) CAShapeLayer *baseLayer;
@property(nonatomic, assign, readwrite) BOOL flippedUpDown;
@property(nonatomic, assign, readwrite) BOOL flippedLeftRight;
@property(nonatomic, assign, readwrite) NSInteger rotation;

@end

@implementation RotationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _baseLayer = [self baseLayer:frame];
        _flippedUpDown = YES;
        _flippedLeftRight = NO;
        _rotation = 0;
        
        self.Left = Green;
        self.Right = Blue;
        self.Middle = Red;
        
        [self.layer addSublayer:_baseLayer];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"ROTATIONS"];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        [label sizeToFit];
        label.center = self.center;
        [self addSubview:label];
    }
    
    return self;
}

- (void)rotate {
    NSInteger left = self.Left;
    NSInteger middle = self.Middle;
    NSInteger right = self.Right;
    self.Left = middle;
    self.Middle = right;
    self.Right = left;
    
    double rotationValue;
    
    switch (_rotation) {
        case 0:
            rotationValue = _flippedUpDown ? degreesToRadians(120) : degreesToRadians(-120);
            _rotation = 1;
            break;
        case 1:
            rotationValue = _flippedUpDown ? degreesToRadians(240) : degreesToRadians(-120);
            _rotation = 2;
            break;
        case 2:
            rotationValue = _flippedUpDown ? degreesToRadians(0) : degreesToRadians(-120);
            _rotation = 0;
            break;
        default:
            rotationValue = M_PI;
            break;
    }
    
    _baseLayer.transform = CATransform3DMakeRotation(rotationValue, 0, 0, 1.0f);
    NSLog(@"rotate - %@", self.description);
}

- (void)flipUpDown {
    NSLog(@"flipUpDown - %@", self.description);
    
    double toValue = _flippedUpDown ? M_PI : M_PI / 180.0;
    _flippedUpDown = !_flippedUpDown;
    
    _baseLayer.transform = CATransform3DMakeRotation(toValue, 0, 0, 1.0f);
}

- (void)flipLeftRight {
    NSInteger left = self.Left;
    NSInteger right = self.Right;
    self.Left = right;
    self.Right = left;
    
    NSLog(@"flipLeftRight - %@", self.description);
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%ld%ld%ld", self.Left, self.Middle, self.Right];
}

#pragma mark - Layer & paths

- (CAShapeLayer*)baseLayer:(CGRect)frame {
    CGSize size = CGSizeMake(frame.size.width, frame.size.height);
    CGFloat angle = M_PI/3;
    CGPoint leftPoint = CGPointMake(0, 0);
    CGPoint rightPoint = CGPointMake(size.width, 0);
    CGPoint v1 = CGPointMake(rightPoint.x - leftPoint.x, rightPoint.y - leftPoint.y);
    CGPoint v2 = CGPointMake(cosf(angle) * v1.x - sinf(angle) * v1.y, sinf(angle) * v1.x + cosf(angle) * v1.y);
    CGPoint topPoint = CGPointMake(leftPoint.x + v2.x, leftPoint.y + v2.y);
    CGPoint centerPoint = CGPointMake((leftPoint.x + rightPoint.x + topPoint.x) / 3, (leftPoint.y + rightPoint.y + topPoint.y) / 3);
    
    CAShapeLayer *midLayer = [[CAShapeLayer alloc] init];
    [midLayer setFillColor:[UIColor redColor].CGColor];
    [midLayer setPath:[self middlePath:leftPoint centerPoint:centerPoint rightPoint:rightPoint].CGPath];
    
    CAShapeLayer *leftLayer = [[CAShapeLayer alloc] init];
    [leftLayer setFillColor:[UIColor greenColor].CGColor];
    [leftLayer setPath:[self leftPath:leftPoint centerPoint:centerPoint topPoint:topPoint].CGPath];
    
    CAShapeLayer *rightLayer = [[CAShapeLayer alloc] init];
    [rightLayer setFillColor:[UIColor blueColor].CGColor];
    [rightLayer setPath:[self rightPath:rightPoint centerPoint:centerPoint topPoint:topPoint].CGPath];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.bounds = frame;
    shapeLayer.frame = frame;
    shapeLayer.position = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    shapeLayer.anchorPoint = CGPointMake(0.5f, centerPoint.y / frame.size.height);
    [shapeLayer addSublayer:leftLayer];
    [shapeLayer addSublayer:midLayer];
    [shapeLayer addSublayer:rightLayer];
    
    return shapeLayer;
}

- (UIBezierPath*)leftPath:(CGPoint)leftPoint centerPoint:(CGPoint)centerPoint topPoint:(CGPoint)topPoint {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:leftPoint];
    [path addLineToPoint:centerPoint];
    [path addLineToPoint:topPoint];
    [path closePath];
    return path;
}

- (UIBezierPath*)middlePath:(CGPoint)leftPoint centerPoint:(CGPoint)centerPoint rightPoint:(CGPoint)rightPoint {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:leftPoint];
    [path addLineToPoint:centerPoint];
    [path addLineToPoint:rightPoint];
    [path closePath];
    return path;
}

- (UIBezierPath*)rightPath:(CGPoint)rightPoint centerPoint:(CGPoint)centerPoint topPoint:(CGPoint)topPoint {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:rightPoint];
    [path addLineToPoint:centerPoint];
    [path addLineToPoint:topPoint];
    [path closePath];
    return path;
}

@end
