# MTMultipleViewController

MTMultipleViewController is a container view controller that allows the
selection of child views based on a UISegmentedControl in the navigation bar.

It does some cool things:

* The navigation bar all of its properties (leftBarButtonItem, rightBarButtonItem, etc) from the currently selected child UIViewController
* Titles for the segmented control are taken from the child view controllers' navigationItem.title properties
* Your child view controllers don't require any modification to be used with this container
* Because MTMultipleViewController uses proper container view controller APIs, all relevant rotation, memory, and view lifecycle messages automatically get passed through to the selected child

## Supported Platforms

iOS 5.0 is a minimum; any release since then is supported. ARC is required (if you have a need
for this project to not require ARC, let me know and I'll fix you up;
I just haven't has a need for it yet).

## Usage

Using MTMultipleViewController is easy. Initialization looks very similar to
that of any of the system view controllers:

```

UIViewController *controllerOne = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
controllerOne.navigationItem.title = @"One";
controllerOne.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:nil action:nil];;

UIViewController *controllerTwo = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
controllerTwo.navigationItem.title = @"Two";
controllerTwo.navigationItem.prompt = @"Controller two's prompt";

MTMultipleViewController *multipleViewController = [[MTMultipleViewController alloc] initWithChildViewControllers:@[controllerOne, controllerTwo]];
/* add multipleViewController into your view controller hierarchy anywhere you'd like */

```

The previous code will give you something that looks like this:

![Controller One](http://mat.geeky.net/static/MTMultipleViewControllerOne.png)
![Controller Two](http://mat.geeky.net/static/MTMultipleViewControllerTwo.png)

You can have any number of child view controllers, but I'd try very hard not to 
exceed three (or two if you have left and right bar button items). Transitions 
between child view controllers aren't animated (it's just a toggle), which
sounds weak, but is actually what you want in this situation. 

Note that the UIBarButtonItem and prompt added above are purely fictional and
would never be done like this in real code. The above only serves to demonstrate
what the UI looks like. 

It should be said that generally, the HIGs dictate that segmented controls in the
title of a view (such as MTMultipleViewController displays) are intended to
select between different filters views into a single set of data (for example, see
the 'Recents' tab in Phone.app, or the 'Connect' tab in the official
Twitter.app). Such filtered views are quite easy to do using a combined
UITableViewController subclass, and if you're using MTMultipleViewController to
realize such a design you're quite possibly doing it wrong. On the other end of
the spectrum, using MTMultipleViewController to toggle between two or more
obviously different view controllers is an equally bad idea; where
MTMultipleViewController shines is in the grey area in between these two
extremes. There should be a natural and complementary relationship between the
data presented by views embedded within an MTMultipleViewController.

## Contributing

Contributions welcome! Fork this repo and submit a pull request (or just open up
a ticket and I'll see what I can do).
