//
//  SionTouchID.m
//  SionTouchID
//
//  Created by 超级腕电商 on 16/7/25.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "SionTouchID.h"

@implementation SionTouchID
- (void)startSionTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<SionTouchIDDelegate>)delegate {
    
    LAContext *context = [[LAContext alloc]init];
    
    context.localizedFallbackTitle = fallbackTitle;
    
    NSError *error = nil;
    
    self.delegate = delegate;
    
    NSAssert(self.delegate != nil, SionNotice(@"SionTouchIDDelegate 不能为空", @"SionTouchIDDelegate must be non-nil"));
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message == nil ? SionNotice(@"默认提示信息", @"The Default Message") : message reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                
                if ([self.delegate respondsToSelector:@selector(SionTouchIDAuthorizeSuccess)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.delegate SionTouchIDAuthorizeSuccess];
                    }];
                    
                }
            } else if (error) {
                
                switch (error.code) {
                        
                    case LAErrorAuthenticationFailed: {
                        
                        if ([self.delegate respondsToSelector:@selector(SionTouchIDAuthorizeFailure)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate SionTouchIDAuthorizeFailure];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorUserCancel: {
                        
                        if ([self.delegate respondsToSelector:@selector(SionTouchIDAuthorizeErrorUserCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate SionTouchIDAuthorizeErrorUserCancel];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorUserFallback: {
                        
                        if ([self.delegate respondsToSelector:@selector(SionTouchIDAuthorizeErrorUserFallback)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate SionTouchIDAuthorizeErrorUserFallback];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorSystemCancel:{
                        
                        if ([self.delegate respondsToSelector:@selector(SionTouchIDAuthorizeErrorSystemCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate SionTouchIDAuthorizeErrorSystemCancel];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDNotEnrolled: {
                        
                        if ([self.delegate respondsToSelector:@selector(SionTouchIDAuthorizeErrorTouchIDNotEnrolled)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate SionTouchIDAuthorizeErrorTouchIDNotEnrolled];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorPasscodeNotSet: {
                        
                        if ([self.delegate respondsToSelector:@selector(SionTouchIDAuthorizeErrorPasscodeNotSet)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate SionTouchIDAuthorizeErrorPasscodeNotSet];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDNotAvailable: {
                        
                        if ([self.delegate respondsToSelector:@selector(SionTouchIDAuthorizeErrorTouchIDNotAvailable)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate SionTouchIDAuthorizeErrorTouchIDNotAvailable];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDLockout: {
                        
                        if ([self.delegate respondsToSelector:@selector(SionTouchIDAuthorizeErrorTouchIDLockout)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate SionTouchIDAuthorizeErrorTouchIDLockout];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorAppCancel:  {
                        
                        if ([self.delegate respondsToSelector:@selector(SionTouchIDAuthorizeErrorAppCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate SionTouchIDAuthorizeErrorAppCancel];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorInvalidContext: {
                        
                        if ([self.delegate respondsToSelector:@selector(SionTouchIDAuthorizeErrorInvalidContext)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate SionTouchIDAuthorizeErrorInvalidContext];
                            }];
                        }
                    }
                        break;
                }
            }
        }];
        
    } else {
        
        if ([self.delegate respondsToSelector:@selector(SionTouchIDIsNotSupport)]) {
            
            [self.delegate SionTouchIDIsNotSupport];
        }
    }
}


@end
