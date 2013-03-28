//
//  MTMultipleViewController.m
//
//  Created by Mat Trudel on 2013-01-23.
//  Copyright (c) 2013 Mat Trudel. All rights reserved.
//

#import "MTMultipleViewController.h"

@interface MTMultipleViewController ()
@property(nonatomic, strong) NSMutableArray *internalViewControllers;
@end

@implementation MTMultipleViewController


#pragma mark - Initializers

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    [self setupInitialState];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self setupInitialState];
  }
  return self;
}

- (void)setupInitialState {
  self.internalViewControllers = [NSMutableArray array];
  UISegmentedControl *titleView = [[UISegmentedControl alloc] initWithItems:[self.viewControllers valueForKeyPath:@"navigationItem.title"]];
  titleView.segmentedControlStyle = UISegmentedControlStyleBar;
  [titleView addTarget:self action:@selector(selectedButtonChanged:) forControlEvents:UIControlEventValueChanged];
  self.navigationItem.titleView = titleView;
}

#pragma mark - View lifecycle


- (void)viewDidLoad {
  [self makeViewControllerVisible:self.viewControllers[self.selectedIndex]];
}

- (void)viewDidUnload {
  [self makeViewControllerInvisible:self.viewControllers[self.selectedIndex]];
}


#pragma mark - Public access methods

- (NSArray *)viewControllers {
  return [self.internalViewControllers copy];
}

- (void)addViewController:(UIViewController *)controller {
  [self insertViewController:controller atIndex:self.viewControllers.count];
}


- (void)insertViewController:(UIViewController *)controller atIndex:(NSUInteger)index {
  [self.internalViewControllers insertObject:controller atIndex:index];
  [self addChildViewController:controller];
  [((UISegmentedControl *)self.navigationItem.titleView) insertSegmentWithTitle:[[controller navigationItem] title] atIndex:index animated:YES];
  if (((UISegmentedControl *)self.navigationItem.titleView).selectedSegmentIndex == -1) {
    ((UISegmentedControl *)self.navigationItem.titleView).selectedSegmentIndex = 0;
  }
}


- (void)setSelectedIndex:(NSUInteger)selectedIndex {
  if (selectedIndex != _selectedIndex) {
    [self makeViewControllerVisible:self.viewControllers[selectedIndex]];
    [self makeViewControllerInvisible:self.viewControllers[_selectedIndex]];

    _selectedIndex = selectedIndex;

    ((UISegmentedControl *)self.navigationItem.titleView).selectedSegmentIndex = selectedIndex;

    if ([self.delegate respondsToSelector:@selector(multipleViewController:didChangeSelectedViewControllerIndex:)]) {
      [self.delegate multipleViewController:self didChangeSelectedViewControllerIndex:selectedIndex];
    }
  }
}


#pragma mark - Internal methods


- (IBAction)selectedButtonChanged:(id)sender {
  self.selectedIndex = [sender selectedSegmentIndex];
}


- (void)makeViewControllerVisible:(UIViewController *)newController {
  if (!self.lockedTitle) {
    self.navigationItem.title = newController.navigationItem.title;
  }
  if (!self.lockedPrompt) {
    self.navigationItem.prompt = newController.navigationItem.prompt;
  }
  if (!self.lockedBackBarButtonItem) {
    self.navigationItem.backBarButtonItem = newController.navigationItem.backBarButtonItem;
  }
  if (!self.lockedHidesBackButton) {
    self.navigationItem.hidesBackButton = newController.navigationItem.hidesBackButton;
  }
  if (!self.lockedLeftItemsSupplementBackButton) {
    self.navigationItem.leftItemsSupplementBackButton = newController.navigationItem.leftItemsSupplementBackButton;
  }
  if (!self.lockedLeftBarButtonItems && newController.navigationItem.leftBarButtonItems) {
    self.navigationItem.leftBarButtonItems = newController.navigationItem.leftBarButtonItems;
  }
  if (!self.lockedLeftBarButtonItem) {
    self.navigationItem.leftBarButtonItem = newController.navigationItem.leftBarButtonItem;
  }
  if (!self.lockedRightBarButtonItems && newController.navigationItem.rightBarButtonItems) {
    self.navigationItem.rightBarButtonItems = newController.navigationItem.rightBarButtonItems;
  }
  if (!self.lockedRightBarButtonItem) {
    self.navigationItem.rightBarButtonItem = newController.navigationItem.rightBarButtonItem;
  }
  newController.view.frame = self.view.bounds;
  [newController beginAppearanceTransition:YES animated:NO];
  [self.view addSubview:newController.view];
  [newController endAppearanceTransition];
}


- (void)makeViewControllerInvisible:(UIViewController *)oldController {
  [oldController beginAppearanceTransition:NO animated:NO];
  [oldController.view removeFromSuperview];
  [oldController endAppearanceTransition];
}

@end