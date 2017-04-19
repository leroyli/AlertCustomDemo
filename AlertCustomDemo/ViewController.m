//
//  ViewController.m
//  AlertCustomDemo
//
//  Created by artios on 2017/4/18.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "ViewController.h"
#import "MM_AlertView.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"click here" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 200, 150, 40);
    button.center = self.view.center;
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction:(UIButton *)sender{
    
    MM_AlertView *alert = [[MM_AlertView alloc] initWithTitle:@"请输入保存的文件名"
                                               inputLabletext:@"文件名称"
                                                  placeholder:@"不超过20个字"
                                                      handler:^(NSString *text, NSInteger index) {
                                                          NSLog(@">>>>>>>>input: %@ index: %lu",text,index);
                                                    }];
    
    [alert show];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
