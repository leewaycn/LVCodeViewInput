//
//  LVCodeInputView.m
//  Code
//
//  Created by 孔友夫 on 2018/5/11.
//  Copyright © 2018年 HSF_Organization. All rights reserved.
//

#import "LVCodeInputView.h"

#import "LVCodeInputLabel.h"


@interface LVCodeInputView ()<UITextFieldDelegate>

/**
 获取输入键盘
 */
@property(nonatomic, strong) UITextField *textField;


/**
 背景图
 */
@property(nonatomic, strong) UIImageView *bgImageView;


/**
 验证码／密码Label
 */
@property(nonatomic, strong) LVCodeInputLabel *label;

@end

@implementation LVCodeInputView


-(UITextField*)textField{
    if(!_textField){
        _textField = [[UITextField alloc]init];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
        _textField.hidden = YES;
    }
    return _textField;
}


-(UIImageView*)bgImageView{
    if(!_bgImageView){
        _bgImageView = [[UIImageView alloc]init];
    }
    return _bgImageView;
}


-(LVCodeInputLabel*)label{
    if(!_label){
        _label = [[LVCodeInputLabel alloc]init];
    }
    return _label;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        [self initUIWithFrame:frame];
        [self initdata];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        self = [self initWithFrame:CGRectZero];
    }
    return self;
}

- (void)initUIWithFrame:(CGRect)frame{

    [self addSubview:self.textField];
    self.textField.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);// frame;
    [self addSubview:self.bgImageView];
    self.bgImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);//;
    [self addSubview:self.label];
    self.label.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);//;

}
-(void)initdata{


    /************************初始值*************************/
    //几位密码
    self.numberOfVertificationCode = 4;
    //每个密码框的背景大小
    self.label.codeSize = CGSizeMake(60, 60);
    //每个密码框背景之间的间隙
    self.label.codeWidthOffset = 10;
    //密码位数
    self.label.numberOfVertificationCode = self.numberOfVertificationCode;
    self.label.secureTextEntry = self.secureTextEntry;
    self.label.font = self.textField.font;



    switch (self.type) {
        case LVCodeInputViewType_Login:
        [self codeType_Login];
        break;

        case LVCodeInputViewType_BindPhoneNum:
        [self codeType_BingPhoneNum];
        break;

        default:
        break;
    }
}



    //登录相关UI变化
-(void)codeType_Login{

    self.label.textColor = [UIColor whiteColor];
    self.label.codeBgImgNameNor = @"input_Number_White_nor";
    self.label.codeBgImgNameSel = @"input_Number_White_sel";
}

    //绑定相关UI变化
-(void)codeType_BingPhoneNum{

    self.label.textColor = [UIColor lightGrayColor];
    self.label.codeBgImgNameNor = @"input_Number_nor";
    self.label.codeBgImgNameSel = @"input_Number_sel";


}
#pragma mark - 代理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField becomeFirstResponder];
    [self bringSubviewToFront:self.textField ];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSLog(@"%@ shouldChangeCharactersInRange %@",textField.text ,string);
    // 判断是不是“删除”字符
    if (string.length != 0) {// 不是“删除”字符
        // 判断验证码/密码的位数是否达到预定的位数
        if (textField.text.length < self.numberOfVertificationCode) {
            self.label.text = [textField.text stringByAppendingString:string];
            self.vertificationCode = self.label.text;

            if (textField.text.length == self.numberOfVertificationCode - 1) {
                if (self.delegate &&[self.delegate respondsToSelector:@selector(codeLVInputView:code:)]) {
                    [self.delegate codeLVInputView:self code:self.vertificationCode];
                }
            }

            return YES;
        } else {

            if (textField.text.length == self.numberOfVertificationCode) {
                if (self.delegate &&[self.delegate respondsToSelector:@selector(codeLVInputView:code:)]) {
                    [self.delegate codeLVInputView:self code:self.vertificationCode];
                }
            }

            return NO;
        }
    } else { // 是“删除”字符
        self.label.text = [textField.text substringToIndex:textField.text.length - 1];
        self.vertificationCode = self.label.text;
        return YES;
    }
}



#pragma mark - setter方法
-(void)setType:(LVCodeInputViewType)type{
    _type = type;
    switch (self.type) {
        case LVCodeInputViewType_Login:
        [self codeType_Login];
        break;

        case LVCodeInputViewType_BindPhoneNum:
        [self codeType_BingPhoneNum];
        break;

        default:
        break;
    }
}
-(void)setBgImageName:(NSString *)bgImageName{
    _bgImageName = bgImageName;

    if (!bgImageName) {
        return;
    }

    self.bgImageView.image = [UIImage imageNamed:bgImageName];
}


-(void)setNumberOfVertificationCode:(NSInteger)numberOfVertificationCode{
    _numberOfVertificationCode = numberOfVertificationCode;
    self.label.numberOfVertificationCode = numberOfVertificationCode;
}


-(void)setSecretCodeImgName:(NSString *)secretCodeImgName{
    _secretCodeImgName = secretCodeImgName;
    self.label.secretCodeImgName = secretCodeImgName;
}

-(void)setSecureTextEntry:(bool)secureTextEntry{
    _secureTextEntry = secureTextEntry;
    self.label.secureTextEntry = secureTextEntry;
}

-(void)setCodeBgImgSize:(CGSize)codeBgImgSize{
    _codeBgImgSize = codeBgImgSize;
    self.label.codeSize = codeBgImgSize;
}

-(void)setCodeBgWidthOffset:(CGFloat)codeBgWidthOffset{
    _codeBgWidthOffset = codeBgWidthOffset;
    self.label.codeWidthOffset = codeBgWidthOffset;
}

@end
