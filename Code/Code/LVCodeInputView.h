//
//  LVCodeInputView.h
//  Code
//
//  Created by 孔友夫 on 2018/5/11.
//  Copyright © 2018年 HSF_Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,LVCodeInputViewType ) {
    LVCodeInputViewType_Login,//登录
    LVCodeInputViewType_BindPhoneNum,//绑定手机号
};
@class LVCodeInputView;
@protocol LVCodeInputViewDelegate <NSObject>

@optional

    /**
     全部输入验证码／密码后，执行该方法，并且将code返回

     @param inputView 输入视图
     @param code 验证码／密码
     */
-(void)codeLVInputView:(LVCodeInputView *)inputView code:(NSString *)code;

@end
@interface LVCodeInputView : UIView
//代理
@property(nonatomic,weak)id<LVCodeInputViewDelegate> delegate;

@property(nonatomic,assign)LVCodeInputViewType type;
/**
 背景图名
 */
@property (nonatomic, copy) NSString *bgImageName;

/**
 每位验证码设置的背景
 */
@property (nonatomic, copy) NSString *vertificationCodeBgImgName;


/**
 验证码几位数
 */
@property (nonatomic, assign) NSInteger numberOfVertificationCode;

/**
 每位 验证码/密码 显示的大小
 */
@property (nonatomic,assign) CGSize codeBgImgSize;

/**
 每个 验证码／密码 偏移量
 例如：
 1－2－3
 1－－2－－3
 */
@property(nonatomic,assign)CGFloat codeBgWidthOffset;

/**
 是否密文显示(YES -> 圆点  NO->验证码)
 */
@property (nonatomic, assign) bool secureTextEntry;

/**
 当 secureTextEntry 设置为 YES时，密文显示的图样式 （默认--小红点）
 */
@property(nonatomic,copy)NSString *secretCodeImgName;

/**
 验证码／密码内容 (通过这里拿到 验证码／密码 的内容)
 */
@property (nonatomic, copy) NSString *vertificationCode;




@end
