//
//  SUPTransitionController.m
//  
//
//  Created by Oisin Prendiville on 9/23/13.
//
//

#import "SUPTransitionController.h"

@implementation SUPTransitionController


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.28f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = finalFrame;
    
    UIView *darkOverlay = [[UIView alloc] initWithFrame:finalFrame];
    darkOverlay.backgroundColor = [UIColor blackColor];
    darkOverlay.alpha = 0.5;
    
    [[transitionContext containerView] insertSubview:toVC.view belowSubview:fromVC.view];
    [[transitionContext containerView] insertSubview:darkOverlay belowSubview:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVC.view.transform = CGAffineTransformMakeTranslation(-finalFrame.size.width,0.0f);
                         darkOverlay.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [darkOverlay removeFromSuperview];
                         if ([transitionContext transitionWasCancelled]) {
                             [toVC.view removeFromSuperview];
                             [transitionContext completeTransition:NO];
                         } else {
                             [fromVC.view removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }
                     }];
}

@end
