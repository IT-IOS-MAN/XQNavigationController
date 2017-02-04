//
//  UIBarButtonItem+Extension.h
//  XQStudent
//
//  Created by MacG on 16/12/19.
//  Copyright (c) 2016年 MacG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+(UIBarButtonItem *)barButtonItemWithImageName:(NSString *) name highImageName:(NSString *) selectName target:(id)target action:(SEL)action;

+(UIBarButtonItem *)backBarButtonItemWithTitle:(NSString *) title imageName:(NSString *) name highImageName:(NSString *) selectName target:(id)target action:(SEL)action;

@end
