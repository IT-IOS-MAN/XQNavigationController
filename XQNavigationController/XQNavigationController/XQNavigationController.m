//
//  XQNavigationController.m
//  XQNavigationController
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "XQNavigationController.h"
#import "UIView+XQFrame.h"

@interface XQNavigationController ()

@property(nonatomic, strong) NSMutableArray *images;

@property(nonatomic, weak) UIImageView *imageView;

@property(nonatomic, weak) UIPanGestureRecognizer *recognizer;

@end

@implementation XQNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    /*
    [self initTabBarItem];
    
    [self setupDefaultTheme];
    */
    [self setupNavigationItem];
    
    [self setupPanGestureRecognizer];
    
    
}

-(void) initNavigationBar
{
    //    self.navigationBar.barTintColor = ;
    //
    //    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:4]};
    //
    //    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attr forState: UIControlStateNormal];
    //
    //    self.navigationBar.tintColor = [UIColor whiteColor];
    
    //    [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault]; //此处使底部线条颜色为红色
    //    [self.navigationBar setShadowImage:[UIImage createImageWithColor:ColorRGB(240, 240, 240)]];
}

/*
-(void) initTabBarItem
{
    [UITabBar appearance].translucent = NO;
    
    [[UITabBar appearance] setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
    [[UITabBar appearance] setShadowImage:[UIImage createImageWithColor:ColorRGB(240, 240, 240)]];
    
    NSDictionary *attr = @{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:20]};
    
    [self.tabBarItem setTitleTextAttributes:attr forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor redColor]];
    
    attr = @{ NSFontAttributeName : [UIFont systemFontOfSize:11], NSForegroundColorAttributeName : APP_THEME_ITEM_COLOR, NSFontAttributeName : [UIFont systemFontOfSize:20]};
    
    [self.tabBarItem setTitleTextAttributes:attr forState:UIControlStateNormal];
}

-(void) setupDefaultTheme
{
    [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage createImageWithColor:ColorRGB(240, 240, 240)]];
    
    NSDictionary *attr = @{NSForegroundColorAttributeName : APP_THEME_COLOR};
    self.navigationBar.titleTextAttributes = attr;
    self.navigationBar.tintColor = APP_THEME_ITEM_COLOR;
}

-(void) setupAppTheme
{
    
    [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:nil];
    NSDictionary *attr = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = attr;
    self.navigationBar.tintColor = [UIColor whiteColor];
}
 */

-(void) setupNavigationItem
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemDidClick:)];
    
    self.navigationItem.backBarButtonItem = backItem;
}

-(void)setupPanGestureRecognizer
{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:recognizer];
    recognizer.enabled = NO;
    self.recognizer = recognizer;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.viewControllers.count > 1) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        self.recognizer.enabled = YES;
        
        [self setupScreenshots];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemDidClick:)];
        
    }
    
    [super pushViewController:viewController animated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    
    if(self.viewControllers.count == 1){
        self.recognizer.enabled = NO;
    }
    
    [self.images removeLastObject];
    self.imageView.image = self.images.lastObject;
    
    return [super popViewControllerAnimated:animated];
}

-(NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    
    while (self.images.count > index) {
        [self.images removeLastObject];
    }
    if (!index) {
        self.recognizer.enabled = NO;
    }
    
    self.imageView.image = self.images.lastObject;
    
    return [super popToViewController:viewController animated:animated];
}

-(NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    
    while (self.images.count > 1) {
        [self.images removeAllObjects];
    }
    self.recognizer.enabled = NO;
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark - 自定义
-(void)setupScreenshots
{
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0.0);
    [self.tabBarController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self.images addObject:image];
    self.imageView.image = image;
}

#pragma mark - 点击事件
-(void)backItemDidClick:(UIBarButtonItem *) backItem
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - 滑动手势
-(void)handlePan:(UIPanGestureRecognizer *) recognizer
{
    
    if (self.viewControllers.count < 2) return;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateChanged:
            if (self.view.xq_x >= 0) {
                
                self.view.xq_x = MAX([recognizer translationInView:self.view].x, 0);
                
            }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            
            if([self.recognizer velocityInView:self.view].x > 1000){
                
                [UIView animateWithDuration:0.1 animations:^{
                    self.view.xq_x =  self.view.xq_width;
                } completion:^(BOOL finished) {
                    
                    if (self.view.xq_x == self.view.xq_width) {
                        [self popViewControllerAnimated:NO];
                    }
                    self.view.xq_x = 0;
                }];
            }else{
                [UIView animateWithDuration:0.2 animations:^{
                    self.view.xq_x = self.view.xq_x > self.view.xq_width * 0.5 ? self.view.xq_width : 0;
                } completion:^(BOOL finished) {
                    
                    if (self.view.xq_x == self.view.xq_width) {
                        [self popViewControllerAnimated:NO];
                    }
                    self.view.xq_x = 0;
                }];
            }
            
            
            
            
        }
            break;
            
        default:
            self.view.xq_x = 0;
            break;
    }
    
    
    
}

#pragma mark - 懒加载
-(NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    
    return _images;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if ([self.view.window.subviews.firstObject isKindOfClass:[UIImageView class]]) {
            _imageView = window.subviews.firstObject;
        }else{
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
            UIView *view = [[UIView alloc] initWithFrame:imageView.bounds];
            view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [imageView addSubview:view];
            [window insertSubview:imageView atIndex:0];
            _imageView = imageView;
        }
        
    }
    return _imageView;
}


@end
