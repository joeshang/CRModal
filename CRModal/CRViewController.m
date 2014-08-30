//
//  CRViewController.m
//  CRModal
//
//  Created by Joe Shang on 8/30/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import "CRViewController.h"
#import "CRModal.h"

@interface CRViewController ()

@property (strong, nonatomic) CRModal *modal;

@end

@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)onShowModalClicked:(id)sender
{
    UIView *modalView = [[[NSBundle mainBundle] loadNibNamed:@"CRModalView" owner:self options:nil] firstObject];
    
    self.modal = [[CRModal alloc] init];
    self.modal.blur = self.blurSwitch.on;
    self.modal.cover = self.coverSwitch.on;
    [self.modal showModalView:modalView];
}

- (IBAction)onCloseClicked:(id)sender
{
    [self.modal dismiss];
    self.modal = nil;
}

@end
