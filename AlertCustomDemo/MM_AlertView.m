//
//  MM_AlertView.m
//  AlertCustomDemo
//
//  Created by artios on 2017/4/18.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "MM_AlertView.h"
#import "Masonry.h"


#define MM_ALERT_VIEW_MARGIN        50.0f
#define MM_ALERT_VIEW_CORNER_RADIUS 3.0f
#define MM_ALERT_LABEL_HEIGHT       30.0f
#define MM_ALERT_LINE_MARGIN        30


@interface MM_AlertView ()

@property (nonatomic, strong) UIView      *keyWindow;
@property (nonatomic, strong) UIView      *mmContentView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView      *buttonsView;
@property (nonatomic, strong) UIButton    *confirmButton;
@property (nonatomic, strong) UIButton    *cancleButton;


@property (nonatomic, copy)   NSString    *title;
@property (nonatomic, copy)   NSString    *tip;
@property (nonatomic, copy)   NSString    *placeholder;
@property (nonatomic, copy)   MMHandler   handler;
@property (nonatomic, assign) NSUInteger  maxInputLength;

@end

@implementation MM_AlertView


- (instancetype)initWithTitle:(NSString *)title
               inputLabletext:(NSString *)inputLabletext
                  placeholder:(NSString *)placeholder
                      handler:(MMHandler)handler
{
    self = [super init];
    if (self) {
        self.title       = title;
        self.tip         = inputLabletext;
        self.placeholder = placeholder;
        self.handler     = handler;
        self.maxInputLength = 20;
        [self setupViews];
    }
    return self;
}


- (void)setupViews{
    
    
    self.frame = CGRectMake(0, 0, self.keyWindow.frame.size.width - MM_ALERT_VIEW_MARGIN, MM_ALERT_VIEW_MARGIN * 4 - 25);
    self.center = self.keyWindow.center;
    self.layer.cornerRadius = 3 * MM_ALERT_VIEW_CORNER_RADIUS;
    self.layer.masksToBounds = YES;
    self.alpha = 0.0f;
     
    
    self.mmContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.keyWindow.frame.size.width - MM_ALERT_VIEW_MARGIN, MM_ALERT_VIEW_MARGIN * 5)];
    self.mmContentView.backgroundColor = [UIColor orangeColor];
    self.mmContentView.layer.cornerRadius = 3 * MM_ALERT_VIEW_CORNER_RADIUS;
    self.mmContentView.layer.masksToBounds = YES;
    [self addSubview:self.mmContentView];
    [self.mmContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.mmContentView.frame.size.width, MM_ALERT_LABEL_HEIGHT)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = self.title;
    [self.mmContentView addSubview:self.titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(MM_ALERT_LINE_MARGIN, MM_ALERT_LABEL_HEIGHT + 10, self.mmContentView.frame.size.width - MM_ALERT_LINE_MARGIN * 2, 0.5)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.mmContentView addSubview:lineView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.font = [UIFont systemFontOfSize:14.0f];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.text = self.tip;
    [self.mmContentView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mmContentView.mas_left).offset(20);
        make.top.equalTo(lineView.mas_bottom).offset(25);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textField.borderStyle = UITextBorderStyleLine;
    self.textField.font = [UIFont systemFontOfSize:14.0f];
    self.textField.backgroundColor = [UIColor orangeColor];
    self.textField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.textField.layer.borderWidth = 1.0f;
    self.textField.textColor = [UIColor whiteColor];
    self.textField.placeholder = self.placeholder;
    [self.mmContentView addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tipLabel.mas_right).offset(5);
        make.centerY.equalTo(tipLabel.mas_centerY);
        make.right.equalTo(self.mmContentView.mas_right).offset(-20);
        make.height.mas_equalTo(25);
    }];
    
    
    self.buttonsView = [[UIView alloc] initWithFrame:CGRectZero];
    self.buttonsView.backgroundColor = [UIColor whiteColor];
    [self.mmContentView addSubview:self.buttonsView];
    [self.buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mmContentView.mas_bottom);
        make.left.equalTo(self.mmContentView.mas_left);
        make.right.equalTo(self.mmContentView.mas_right);
        make.height.mas_equalTo(60);
    }];
    
    self.confirmButton = [self setupButtonWithTitle:@"确定" bgColor:[UIColor orangeColor] titleColor:[UIColor whiteColor]];
    self.cancleButton  = [self setupButtonWithTitle:@"取消" bgColor:[UIColor lightGrayColor] titleColor:[UIColor blackColor]];
    
    self.confirmButton.tag = 0;
    self.cancleButton.tag  = 1;
    
    [self.confirmButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.buttonsView addSubview:self.confirmButton];
    [self.buttonsView addSubview:self.cancleButton];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.buttonsView.mas_centerX).offset(-30);
        make.centerY.equalTo(self.buttonsView.mas_centerY);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.buttonsView.mas_centerX).offset(30);
        make.centerY.equalTo(self.buttonsView.mas_centerY);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void)show{
    
    [self.keyWindow addSubview:self];
    self.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.0f);
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.alpha = 1;
        self.layer.transform = CATransform3DIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
        self.layer.transform = CATransform3DMakeScale(0.9f, 0.9f, 1.0f);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}

- (void)buttonAction:(UIButton *)sender{
    if ( self.handler ){
        self.handler(self.textField.text, sender.tag);
    }
    [self hide];
}


- (UIButton *)setupButtonWithTitle:(NSString *)title
                           bgColor:(UIColor *)bgColor
                        titleColor:(UIColor *)titleColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectZero;
    button.layer.cornerRadius = 3.0f;
    button.layer.masksToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = bgColor;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    return button;
}

- (void)notifyTextChange:(NSNotification *)n{
    if ( self.maxInputLength == 0 ){
        return;
    }
    
    if ( n.object != self.inputView ){
        return;
    }
    
    UITextField *textField = self.inputView;
    
    NSString *toBeString = textField.text;
    
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (toBeString.length > self.maxInputLength) {
            textField.text = [self mm_truncateString:toBeString ByCharLength:self.maxInputLength];
        }
    }
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (UIView *)keyWindow{
    return [[[UIApplication sharedApplication] delegate] window];
}


- (NSString *)mm_truncateString:(NSString *)string ByCharLength:(NSUInteger)charLength{
    __block NSUInteger length = 0;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              
                              if ( length+substringRange.length > charLength ){
                                  *stop = YES;
                                  return;
                              }
                              
                              length+=substringRange.length;
                          }];
    
    return [string substringToIndex:length];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

