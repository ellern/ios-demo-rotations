//
//  ViewController.m
//  Rotations
//
//  Created by Martin Ellern Bilgrau on 22/04/15.
//
//

#import "ViewController.h"
#import "RotationView.h"

@interface ViewController ()

@end

@implementation ViewController {
    RotationView *_rotationView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _rotationView = [[RotationView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   self.view.bounds.size.width / 2,
                                                                   self.view.bounds.size.width / 2)];
    
    _rotationView.center = self.view.center;
    
    [self.view addSubview:_rotationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rotate:(id)sender {
    [_rotationView rotate];
}

- (IBAction)flipUpDown:(id)sender {
    [_rotationView flipUpDown];
}

- (IBAction)flipLeftRight:(id)sender {
    [_rotationView flipLeftRight];
}

@end
