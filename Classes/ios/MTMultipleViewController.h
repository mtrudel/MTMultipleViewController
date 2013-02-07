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

@property(nonatomic) BOOL lockedTitle;
@property(nonatomic) BOOL lockedPrompt;
@property(nonatomic) BOOL lockedBackBarButtonItem;
@property(nonatomic) BOOL lockedHidesBackButton;
@property(nonatomic) BOOL lockedLeftItemsSupplementBackButton;
@property(nonatomic) BOOL lockedLeftBarButtonItems;
@property(nonatomic) BOOL lockedLeftBarButtonItem;
@property(nonatomic) BOOL lockedRightBarButtonItems;
@property(nonatomic) BOOL lockedRightBarButtonItem;

- (id)initWithChildViewControllers:(NSArray *)controllers;

- (void)addViewController:(UIViewController *)controller;
- (void)insertViewController:(UIViewController *)controller atIndex:(NSUInteger)index;

@end
