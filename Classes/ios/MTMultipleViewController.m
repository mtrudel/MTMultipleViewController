//
//  MTMultipleViewController.m
//
//  Created by Mat Trudel on 2013-01-23.
//  Copyright (c) 2013 Mat Trudel. All rights reserved.
//

#import "MTMultipleViewController.h"

@interface MTMultipleViewController ()
@property(nonatomic, strong) NSMutableArray *internalViewControllers;
- (void)makeViewControllerVisible:(UIViewController *)newController;
- (void)makeViewControllerInvisible:(UIViewController *)oldController;
@end


@implementation MTMultipleViewController


#pragma mark - Initializers


/**
 * This is the designated initializer for this class.
 */
- (id)initWithChildViewControllers:(NSArray *)controllers {
  if (self = [super initWithNibName:nil bundle:nil]) {
    self.internalViewControllers = [NSMutableArray arrayWithCapacity:controllers.count];
    for (UIViewController *controller in controllers) {
      [self addViewController:controller];
    }
  }
  return self;
}


- (void)awakeFromNib {
  self.internalViewControllers = [NSMutableArray array];
}


#pragma mark - View lifecycle


- (void)viewDidLoad {
  UISegmentedControl *titleView = [[UISegmentedControl alloc] initWithItems:[self.viewControllers valueForKeyPath:@"navigationItem.title"]];
  titleView.segmentedControlStyle = UISegmentedControlStyleBar;
  [titleView addTarget:self action:@selector(selectedButtonChanged:) forControlEvents:UIControlEventValueChanged];
  self.navigationItem.titleView = titleView;

  ((UISegmentedControl *)self.navigationItem.titleView).selectedSegmentIndex = self.selectedIndex;
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
  [((UISegmentedControl *)self.navigationItem.titleView) insertSegmentWithTitle:[[controller navigationItem] title] atIndex:index animated:YES];

  if (self.viewControllers.count == 1) {
    self.selectedIndex = 0;
  }
}


- (void)setSelectedIndex:(NSUInteger)selectedIndex {
  if (selectedIndex != _selectedIndex) {
    ((UISegmentedControl *)self.navigationItem.titleView).selectedSegmentIndex = selectedIndex;

    [self makeViewControllerVisible:self.viewControllers[selectedIndex]];
    [self makeViewControllerInvisible:self.viewControllers[_selectedIndex]];

    _selectedIndex = selectedIndex;
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
  [self addChildViewController:newController];
  newController.view.frame = self.view.bounds;
  [self.view addSubview:newController.view];
  [newController didMoveToParentViewController:self];
}


- (void)makeViewControllerInvisible:(UIViewController *)oldController {
  [oldController willMoveToParentViewController:nil];
  [oldController.view removeFromSuperview];
  [oldController removeFromParentViewController];
}

@end