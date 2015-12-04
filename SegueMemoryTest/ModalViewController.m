//
//  ModalViewController.m
//  SegueMemoryTest
//
//  Created by Oisin Prendiville on 03/12/2015.
//  Copyright © 2015 Oisin Prendiville. All rights reserved.
//

#import "ModalViewController.h"

@implementation ModalViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillAppear %@",self);
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
