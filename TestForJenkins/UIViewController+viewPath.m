//
//  UIViewController+viewPath.m
//  TestForJenkins
//
//  Created by dvt04 on 17/8/23.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "UIViewController+viewPath.h"
#import <objc/runtime.h>

static NSString *previousViewController;
static NSString *currentViewController;


@implementation UIViewController (viewPath)

+ (void)load
{
#if 1
    Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method new_viewWillAppear = class_getInstanceMethod(self, @selector(hook_viewWillAppear:));
    method_exchangeImplementations(viewWillAppear, new_viewWillAppear);

    Method viewWillDisappear = class_getInstanceMethod(self, @selector(viewWillDisappear:));
    Method new_viewWillDisappear = class_getInstanceMethod(self, @selector(hook_viewWillDisappear:));
    method_exchangeImplementations(viewWillDisappear, new_viewWillDisappear);
#else
    Method m_viewWillAppear = class_getInstanceMethod([UIViewController class], @selector(viewWillAppear:));
    class_addMethod([UIViewController class], @selector(hook_viewWillAppear:), method_getImplementation(m_viewWillAppear), method_getTypeEncoding(m_viewWillAppear));
    method_setImplementation(m_viewWillAppear, class_getMethodImplementation([self class], @selector(hook_viewWillAppear:)));

    Method m_viewWillDisappear = class_getInstanceMethod([UIViewController class], @selector(viewWillDisappear:));
    class_addMethod([UIViewController class], @selector(hook_viewWillDisappear:), method_getImplementation(m_viewWillDisappear), method_getTypeEncoding(m_viewWillDisappear));
    method_setImplementation(m_viewWillDisappear, class_getMethodImplementation([self class], @selector(hook_viewWillDisappear:)));
#endif
    
}

- (void)hook_viewWillAppear:(BOOL)animated
{
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)self;
        currentViewController = NSStringFromClass([nav.topViewController class]);
    } else {
        currentViewController = NSStringFromClass([self class]);
    }
    
    NSLog(@"previousViewController is %@ ", previousViewController);
    NSLog(@"currentViewController is %@, name is :%@", currentViewController, self.navigationItem.title);
}

- (void)hook_viewWillDisappear:(BOOL)animated
{
    previousViewController = NSStringFromClass([self class]);
}

@end
