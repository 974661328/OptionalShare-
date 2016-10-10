//
//  WXNavigationController.h
//  WXWeibo
//
//  Created by wei.chen on 13-5-13.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationController : UINavigationController {
    UIPanGestureRecognizer *_pan;
    //动画时间
    double animationTime;
}

@property (nonatomic,assign) BOOL canDragBack;

@end
