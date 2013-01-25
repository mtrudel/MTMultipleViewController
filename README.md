# MTMultipleViewController

MTMultipleViewController is a container view controller that  allows the
selection of child views based on a UISegmentedControl in the navigation bar.
The navigation bar inherits left,right and back button items from the currently
selected child UIViewController, and titles for the segmented control are taken
from the child view controllers' UINavigationItem title properties. The upshot
of all of this is that your child view controllers don't require any
modification to be used with this container.

## Supported Platforms

iOS 5.0 is a minimum; any release since then is supported. ARC is required (if you have a need
for this project to not require ARC, just let me know and I'll fix you up).

## Usage

TBD

## Contributing

Contributions welcome! Fork this repo and submit a pull request (or just open up
a ticket, and I'll see what I can do).
