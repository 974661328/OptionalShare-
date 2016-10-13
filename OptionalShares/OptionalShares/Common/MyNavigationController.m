//
//  WXNavigationController.m
//  WXWeibo
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "MyNavigationController.h"

#define KEY_WINDOW  [[UIApplication sharedApplication] keyWindow]

/////////////////////////////////////////////////////////////////////////////
#pragma mark - WXNavigationBar 子类化UINavigationBar
@interface WXNavigationBar : UINavigationBar
@end
@implementation WXNavigationBar
//禁用导航栏的pop动画
- (UINavigationItem *)popNavigationItemAnimated:(BOOL)animated {
    return [super popNavigationItemAnimated:NO];
}
@end

@interface MyNavigationController (){
    CGPoint startTouch;
    BOOL isMoving;
    
    UIImageView *backImageView;
}

@property (nonatomic,strong) NSMutableArray *backImages;

@end

@implementation MyNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.backImages = [[NSMutableArray alloc]initWithCapacity:2];
        self.canDragBack = YES;        
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {

        
        self.backImages = [[NSMutableArray alloc]initWithCapacity:2];
        self.canDragBack = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (ios7) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
        
    //1.创建自定义导航栏对象
    WXNavigationBar *navigationBar = [[WXNavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self setValue:navigationBar forKey:@"navigationBar"];
    
    navigationBar.translucent = NO;
    
    //2.创建滑动手势,实现左右滑动视图
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_pan setEnabled:NO];
    [self.view addGestureRecognizer:_pan];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//////////////////////////////抽屉式导航////////////////////////////////////////

- (void)pan:(UIPanGestureRecognizer *)pan {
    //手势开始
    if (pan.state == UIGestureRecognizerStateBegan) {
        if (self.viewControllers.count <= 1 || !self.canDragBack) {
            return;
        }
        
        isMoving = NO;
        startTouch = [pan locationInView:KEY_WINDOW];
    }
    else if(pan.state == UIGestureRecognizerStateChanged) {
        if (self.viewControllers.count <= 1 || !self.canDragBack) {
            return;
        }
        
        CGPoint moveTouch = [pan locationInView:KEY_WINDOW];
        
        if (!isMoving && moveTouch.x-startTouch.x > 10) {
            backImageView.image = [self.backImages lastObject];
            isMoving = YES;
        }
        
        [self moveViewWithX:moveTouch.x - startTouch.x];
    
    }
    else if(pan.state == UIGestureRecognizerStateEnded) {
        if (self.viewControllers.count <= 1 || !self.canDragBack) {
            return;
        }
        
        CGPoint endTouch = [pan locationInView:KEY_WINDOW];
        
        if (endTouch.x - startTouch.x > 50) {
            animationTime =.35 - (endTouch.x - startTouch.x) / kScreenWidth * .35;
            [self popViewControllerAnimated:NO];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                isMoving = NO;
            }];
        }
    }
    else if(pan.state == UIGestureRecognizerStateCancelled) {
        if (self.viewControllers.count <= 1 || !self.canDragBack) {
            return;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            isMoving = NO;
        }];
    }
}

#pragma mark - override UINavigationController方法覆写
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //给当前视图照一个照片
    UIImage *capture = [self capture];
    
    if (capture != nil) {
        [self.backImages addObject:capture];
    }
    
    if (self.viewControllers.count == 1) {
        [_pan setEnabled:YES];
    }
    
    [super pushViewController:viewController animated:NO];
    
    if (backImageView == nil) {
        CGFloat height = kScreenHeight - 20;
        if (ios7) {
            height = kScreenHeight;
        }
        CGRect frame = CGRectMake(0, 0, kScreenWidth, height);
        
        backImageView = [[UIImageView alloc] initWithFrame:frame];
        backImageView.backgroundColor = [UIColor orangeColor];
    }
    if (backImageView.superview == nil) {
        [self.view.superview insertSubview:backImageView
                              belowSubview:self.view];
    }
    
    if (self.viewControllers.count == 1) {
        return;
    }
    
    backImageView.image = [self.backImages lastObject];
    
    [self moveViewWithX:320];
    [UIView animateWithDuration:.35 animations:^{
        [self moveViewWithX:0];
    } completion:^(BOOL finished) {
        backImageView.left = -200;
    }];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if (animated == YES) {
        animationTime = .35;
    }
    if (self.viewControllers.count == 2) {
        [_pan setEnabled:NO];
    }
    
    [UIView animateWithDuration:animationTime animations:^{
        [self moveViewWithX:320];
    } completion:^(BOOL finished) {
        CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 20);
        frame.origin.x = 0;
        self.view.frame = frame;
        
        //先导航控制器，在移除图片
        [super popViewControllerAnimated:NO];
        
        [self.backImages removeLastObject];
        backImageView.image = [self.backImages lastObject];
        
        CFRunLoopStop(CFRunLoopGetCurrent());
    }];
    
    CFRunLoopRun();
    
    return nil;
}

#pragma mark - Utility Methods -
//获取当前屏幕视图的快照图片
- (UIImage *)capture {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    UIView *view = keyWindow.rootViewController.view;//self.mainViewController.view;
    if (view == nil) {
        NSLog(@"快照视图为空");
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"%f,%f",img.size.height,img.size.width);
    UIGraphicsEndImageContext();
    
    return img;
}

//移动导航控制器的根视图self.view
- (void)moveViewWithX:(float)x {
    
    x = x>320?320:x;
    x = x<0?0:x;
    
    CGFloat height = kScreenHeight - 20;
    if (ios7) {
        height = kScreenHeight;
    }
    
    CGRect frame = CGRectMake(0, 0, kScreenWidth, height);
    frame.origin.x = x;
    self.view.frame = frame;
    
    CGFloat m = 200.0 * x /320.0;
    backImageView.left = m-200;
}

@end
