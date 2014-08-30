//
//  CRModal.m
//  CRModal
//
//  Created by Joe Shang on 8/30/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import "CRModal.h"
#import "UIImage+Blur.h"

#define kCRModalAlphaShow               1.0
#define kCRModalAlphaDismiss            0.0
#define kCRModalAnimationDuration       0.3
#define kCRModalBlurValue               0.3

@interface CRModal ()

@property (nonatomic, strong) UIView *popupView;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIImageView *blurView;

@property (nonatomic, assign) CGAffineTransform popupOriginTransform;

@end

@implementation CRModal

#pragma mark - init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _tapOutsideToDismiss = YES;
        _cover = YES;
        _blur = NO;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = [[UIScreen mainScreen] bounds];
}

#pragma mark - show & dismiss

- (void)showModalView:(UIView *)modalView animated:(BOOL)animated
{
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    [rootViewController.view addSubview:self.view];
    self.view.alpha = kCRModalAlphaDismiss;
    
    if (self.tapOutsideToDismiss)
    {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(onTapOutside:)];
        tapGestureRecognizer.delegate = self;
        [self.view addGestureRecognizer:tapGestureRecognizer];
    }
    
    if (self.blur)
    {
        UIImage *image = [self screenShotForView:rootViewController.view];
        image = [image boxblurImageWithBlur:kCRModalBlurValue];
        self.blurView = [[UIImageView alloc] initWithImage:image];
        self.blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:self.blurView];
    }
    
    if (self.cover)
    {
        self.coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.coverView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        [self.view addSubview:self.coverView];
    }
    
    self.popupView = [[UIView alloc] initWithFrame:modalView.bounds];
    self.popupView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
                                    | UIViewAutoresizingFlexibleBottomMargin
                                    | UIViewAutoresizingFlexibleLeftMargin
                                    | UIViewAutoresizingFlexibleRightMargin;
    self.popupView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    [self.popupView addSubview:modalView];
    [self.view addSubview:self.popupView];
    
    [UIView animateWithDuration:kCRModalAnimationDuration animations:^{
        self.view.alpha = kCRModalAlphaShow;
    }];
    
    if (animated)
    {
        self.popupView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.popupOriginTransform = self.popupView.transform;
        [UIView animateWithDuration:kCRModalAnimationDuration animations:^{
            self.popupView.transform = CGAffineTransformIdentity;
        }];
    }
    else
    {
        self.popupOriginTransform = self.popupView.transform;
    }
}

- (void)showModalView:(UIView *)modalView
{
    [self showModalView:modalView animated:YES];
}

- (void)dismissWithCompletion:(void(^)())completion
{
    [UIView animateWithDuration:kCRModalAnimationDuration
                     animations:^{
                         self.view.alpha = kCRModalAlphaDismiss;
                         self.popupView.transform = self.popupOriginTransform;
                     }
                     completion:^(BOOL finished){
                         [self.view removeFromSuperview];
                         if (completion)
                         {
                             completion();
                         }
                     }];
}

- (void)dismiss
{
    [self dismissWithCompletion:nil];
}

- (void)onTapOutside:(id)sender
{
    [self dismissWithCompletion:nil];
}

- (UIImage *)screenShotForView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

@end
