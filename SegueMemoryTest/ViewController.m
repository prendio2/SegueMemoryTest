//
//  ViewController.m
//  SegueMemoryTest
//
//  Created by Oisin Prendiville on 03/12/2015.
//  Copyright © 2015 Oisin Prendiville. All rights reserved.
//

#import "ViewController.h"
#import "SUPTransitionController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation ViewController

- (IBAction)handlePan:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:sender.view];
    CGFloat percentageComplete = fabs(translation.x / sender.view.frame.size.width);
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            [self showModalByUsingSegue:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [self.interactionController updateInteractiveTransition:percentageComplete];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            [self.interactionController cancelInteractiveTransition];
            break;
        default:
            break;
    }
}

- (void)showModalByUsingSegue:(BOOL)useSegue {
    self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    self.interactionController.completionSpeed = 0.5f;
    self.interactionController.completionCurve = UIViewAnimationCurveEaseInOut;
    
    if (useSegue) {
        NSLog(@"Using a segue. This will never dealloc.");
        [self performSegueWithIdentifier:@"modalSegueIdentifier" sender:nil];
    } else {
        NSLog(@"Presenting manually. Will dealloc just fine.");
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"modalViewController"];
        vc.transitioningDelegate = self;
        [self presentViewController:vc animated:YES completion:NULL];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    segue.destinationViewController.transitioningDelegate = self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[SUPTransitionController alloc] init];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController;
}

@end
