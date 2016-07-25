//
//  SionTouchID.h
//  SionTouchID
//
//  Created by 超级腕电商 on 16/7/25.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
#if TARGET_IPHONE_SIMULATOR
#define SionNotice(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-US"] ? Chinese : English
#elif TARGET_OS_IPHONE
#define SionNotice(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-CN"] ? Chinese : English
#endif

@class SionTouchID;

@protocol SionTouchIDDelegate <NSObject>

@required

/**
 *  TouchID验证成功
 *
 *  (English Comments) Authentication Successul
 */
- (void)SionTouchIDAuthorizeSuccess;

/**
 *  TouchID验证失败
 *
 *  (English Comments) Authentication Failure
 */
- (void)SionTouchIDAuthorizeFailure;

@optional
/**
 *  取消TouchID验证 (用户点击了取消)
 *
 *  (English Comments) Authentication was canceled by user (e.g. tapped Cancel button).
 */
- (void)SionTouchIDAuthorizeErrorUserCancel;

/**
 *  在TouchID对话框中点击输入密码按钮
 *
 *  (English Comments) User tapped the fallback button
 */
- (void)SionTouchIDAuthorizeErrorUserFallback;

/**
 *  在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
 *
 *  (English Comments) Authentication was canceled by system (e.g. another application went to foreground).
 */
- (void)SionTouchIDAuthorizeErrorSystemCancel;

/**
 *  无法启用TouchID,设备没有设置密码
 *
 *  (English Comments) Authentication could not start, because passcode is not set on the device.
 */
- (void)SionTouchIDAuthorizeErrorPasscodeNotSet;

/**
 *  设备没有录入TouchID,无法启用TouchID
 *
 *  (English Comments) Authentication could not start, because Touch ID has no enrolled fingers
 */
- (void)SionTouchIDAuthorizeErrorTouchIDNotEnrolled;

/**
 *  该设备的TouchID无效
 *
 *  (English Comments) Authentication could not start, because Touch ID is not available on the device.
 */
- (void)SionTouchIDAuthorizeErrorTouchIDNotAvailable;

/**
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 *
 *  (English Comments) Authentication was not successful, because there were too many failed Touch ID attempts and Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.
 *
 */
- (void)SionTouchIDAuthorizeErrorTouchIDLockout;

/**
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 *
 *  (English Comments) Authentication was canceled by application (e.g. invalidate was called while authentication was inprogress).
 *
 */
- (void)SionTouchIDAuthorizeErrorAppCancel;

/**
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
 *
 *  (English Comments) LAContext passed to this call has been previously invalidated.
 */
- (void)SionTouchIDAuthorizeErrorInvalidContext;

/**
 *  当前设备不支持指纹识别
 *
 *  (English Comments) The current device does not support fingerprint identification
 */
-(void)SionTouchIDIsNotSupport;

@end

@interface SionTouchID : LAContext

@property (nonatomic, weak) id<SionTouchIDDelegate> delegate;

/**
 *  发起TouchID验证 (Initiate TouchID validation)
 *
 *  @param message 提示框需要显示的信息 默认为：输入密码 (Fallback button title. Default is "Enter Password")
 */
- (void)startSionTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<SionTouchIDDelegate>)delegate;

@end
