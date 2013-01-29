//
//  MTMultipleViewController.h
//
//  Created by Mat Trudel on 2013-01-23.
//  Copyright (c) 2013 Mat Trudel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTMultipleViewController : UIViewController
@property(nonatomic) NSUInteger selectedIndex;
@property(nonatomic, readonly) NSArray *viewControllers;

- (id)initWithChildViewControllers:(NSArray *)controllers;

- (void)addViewController:(UIViewController *)controller;
- (void)insertViewController:(UIViewController *)controller atIndex:(NSUInteger)index;

@end
