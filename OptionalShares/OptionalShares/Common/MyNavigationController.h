//
//  WXNavigationController.h
//  WXWeibo
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationController : UINavigationController {
    UIPanGestureRecognizer *_pan;
    //动画时间
    double animationTime;
}

@property (nonatomic,assign) BOOL canDragBack;

@end
