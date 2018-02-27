//
//  BSBaseNavigationViewController.m
//  Pods
//
//  Created by Yang.Lv on 2017/6/12.
//
//

#import "LYBaseNavigationViewController.h"

@interface LYBaseNavigationViewController ()

@end

@implementation LYBaseNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/** @override，处理侧滑手势 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    self.interactivePopGestureRecognizer.delegate = (id)viewController;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.enabled = [self.viewControllers count] > 1;
}

#pragma mark - UIViewController orientation
- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

@end
