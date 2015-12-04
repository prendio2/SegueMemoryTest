# SegueMemoryTest

[Radar 23763386](http://openradar.appspot.com/23763386)

## Summary:
View controller presented with performSegue is never deallocated if the transition is cancelled

## Steps to Reproduce:
1. Create a modal segue between two view controllers in a storyboard
2. Create a pan gesture recogniser that performs that segue using a custom animation controller and an interaction controller
3. When the gesture recogniser ends call cancelInteractiveTransition on the interaction controller

## Expected Results:
The transition is cancelled and the view controller that was created is released and deallocated

##mActual Results:
The transition is cancelled but the presented view controller is retained. Repeated calls to the segue continue to create new instances of the view controller that are never released.

## Regression:
iOS 9.1 on device and in simulator
