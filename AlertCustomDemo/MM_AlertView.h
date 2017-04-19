//
//  MM_AlertView.h
//  AlertCustomDemo
//
//  Created by artios on 2017/4/18.
//  Copyright © 2017年 artios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MMHandler)(NSString *text , NSInteger index);

@interface MM_AlertView : UIView

- (instancetype)initWithTitle:(NSString *)title
               inputLabletext:(NSString *)inputLabletext
                  placeholder:(NSString *)placeholder
                      handler:(MMHandler)handler;

- (void)show;

@end
