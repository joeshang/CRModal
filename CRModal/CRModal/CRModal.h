//
//  CRModal.h
//  CRModal
//
//  Created by Joe Shang on 8/30/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRModal : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL tapOutsideToDismiss;
@property (nonatomic, assign) BOOL blur;
@property (nonatomic, assign) BOOL cover;

- (void)showModalView:(UIView *)modalView;
- (void)showModalView:(UIView *)modalView animated:(BOOL)animated;
- (void)dismiss;
- (void)dismissWithCompletion:(void(^)())completion;

@end
