//
//  MyBlownupImageViewController.m
//  CardForgeCopy
//
//  Created by Michael Snowden on 7/27/14.
//  Copyright (c) 2014 Michael Snowden. All rights reserved.
//

#import "MyBlownupImageViewController.h"

@interface MyBlownupImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MyBlownupImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageView.image = _images[_indexOfSelectedImage];
    
}
- (IBAction)swipe:(UISwipeGestureRecognizer *)swipeGesture {
    
}

@end
