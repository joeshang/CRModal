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
    
    CRModalCoverOptions option;
    if (self.blurSwitch.on && self.coverSwitch.on)
    {
        option = CRModalOptionCoverDarkBlur;
    }
    else if (self.blurSwitch.on)
    {
        option = CRModalOptionCoverBlur;
    }
    else
    {
        option = CRModalOptionCoverDark;
    }
    
    [CRModal showModalView:modalView
               coverOption:option
       tapOutsideToDismiss:YES
                  animated:YES
                completion:^{
                    NSLog(@"modal dismiss");
                }];
}

- (IBAction)onCloseClicked:(id)sender
{
    [CRModal dismiss];
}

@end
