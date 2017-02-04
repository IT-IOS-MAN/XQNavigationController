//
//  UIBarButtonItem+Extension.m
//  XQStudent
//
//  Created by MacG on 16/12/19.
//  Copyright (c) 2016年 MacG. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+(UIBarButtonItem *)barButtonItemWithImageName:(NSString *) name highImageName:(NSString *) selectName target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    if (selectName) {
        [btn setImage:[UIImage imageNamed:selectName] forState:UIControlStateHighlighted];
    }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+(UIBarButtonItem *)backBarButtonItemWithTitle:(NSString *) title imageName:(NSString *) name highImageName:(NSString *) selectName target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    if (selectName) {
        [btn setImage:[UIImage imageNamed:selectName] forState:UIControlStateHighlighted];
    }
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
