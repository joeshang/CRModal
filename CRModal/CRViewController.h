//
//  CRViewController.h
//  CRModal
//
//  Created by Joe Shang on 8/30/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *blurSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *coverSwitch;

- (IBAction)onShowModalClicked:(id)sender;
- (IBAction)onCloseClicked:(id)sender;

@end
