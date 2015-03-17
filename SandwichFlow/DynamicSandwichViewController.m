//
//  DynamicSandwichViewController.m
//  SandwichFlow
//
//  Created by Nate on 16/03/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "DynamicSandwichViewController.h"
#import "AppDelegate.h"
#import "Sandwich.h"
#import "SandwichViewController.h"

@interface DynamicSandwichViewController ()
{
    NSMutableArray *views;
    NSMutableArray *sandwiches;
    
    BOOL draggingView;
    CGPoint previousTouchPoint;
    UIGravityBehavior *gravity;
    UIDynamicAnimator *animator;
    
    BOOL viewDocked;
    UISnapBehavior *snap;
    
    BOOL viewBounced;
}

@end

@implementation DynamicSandwichViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    views = [[NSMutableArray alloc] init];
    sandwiches = [self sandwiches];
    draggingView = NO;
    previousTouchPoint = CGPointZero;
    gravity = [[UIGravityBehavior alloc] init];
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    viewDocked = NO;
    viewBounced = NO;
    
//    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background-LowerLayer"]];
//    [self.view addSubview:backgroundImageView];
//    
//    UIImageView *header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Sarnie"]];
//    header.center = CGPointMake(220, 190);
//    [self.view addSubview:header];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background-LowerLayer"]];
    backgroundImageView.frame = CGRectInset(self.view.frame, -50, -50);
    [self addMotionEffectToView:backgroundImageView andMagnitude:50];
    
    UIImageView *midLayerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background-MidLayer"]];
    [self.view addSubview:midLayerImageView];
    
    UIImageView *header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Sarnie"]];
    header.center = CGPointMake(220, 190);
    [self.view addSubview:header];
    [self addMotionEffectToView:header andMagnitude:-20];
    
    [animator addBehavior:gravity];
    gravity.magnitude = 4.0;
    
    CGFloat offset = 260;
    for (Sandwich *sandwich in sandwiches)
    {
        [views addObject:[self addReciptAtOffset:offset withSandwich:sandwich]];
        offset -= 50;
    }
}

- (void)addMotionEffectToView: (UIView *)view andMagnitude: (double)magnitude
{
    UIInterpolatingMotionEffect *xMotion = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xMotion.minimumRelativeValue = [NSNumber numberWithDouble:-magnitude];
    xMotion.maximumRelativeValue = [NSNumber numberWithDouble:magnitude];
    
    UIInterpolatingMotionEffect *yMotion = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yMotion.minimumRelativeValue = [NSNumber numberWithDouble:-magnitude];
    yMotion.maximumRelativeValue = [NSNumber numberWithDouble:magnitude];
    
    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
    group.motionEffects = @[xMotion, yMotion];
    
    [view addMotionEffect:group];
}

- (NSMutableArray *)sandwiches
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    return [appDelegate sandwiches];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)addReciptAtOffset: (CGFloat)offset withSandwich: (Sandwich *)sandwich
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SandwichViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SandwichVC"];
    
    viewController.sandwich = sandwich;
    viewController.view.frame = CGRectOffset(self.view.bounds, 0, self.view.bounds.size.height - offset);
    
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [viewController.view addGestureRecognizer:pan];
    
    NSMutableArray *viewsArray = [[NSMutableArray alloc] init];
    [viewsArray addObject:viewController.view];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:viewsArray];
    [animator addBehavior:collision];
    
    float boundary = viewController.view.frame.origin.y + viewController.view.frame.size.height + 1;
    CGPoint boundaryStart = CGPointMake(0, boundary);
    CGPoint boundaryEnd = CGPointMake(self.view.bounds.size.width, boundary);
    [collision addBoundaryWithIdentifier:@"1" fromPoint:boundaryStart toPoint:boundaryEnd];
    
    CGPoint boundaryStart2 = CGPointMake(0, 0);
    CGPoint boundaryEnd2 = CGPointMake(self.view.bounds.size.width, 0);
    [collision addBoundaryWithIdentifier:@"2" fromPoint:boundaryStart2 toPoint:boundaryEnd2];
    collision.collisionDelegate = self;
    
    [gravity addItem:viewController.view];
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:viewsArray];
    [animator addBehavior:itemBehavior];
    
    return viewController.view;
}

- (UIDynamicItemBehavior *)itemBehaviorForView: (UIView *)view
{
    for (id behavior in animator.behaviors)
    {
        if ([behavior isKindOfClass:[UIDynamicItemBehavior class]])
        {
            UIDynamicItemBehavior *itemBehavior = behavior;
            if (itemBehavior.items.firstObject == view)
            {
                return itemBehavior;
            }
        }
    }
    return nil;
}

- (void)tryDockView: (UIView *)view
{
    BOOL viewHasReachedDockLocation = view.frame.origin.y < 100;
    if (viewHasReachedDockLocation)
    {
        if (!viewDocked)
        {
            snap = [[UISnapBehavior alloc] initWithItem:view snapToPoint:self.view.center];
            [animator addBehavior:snap];
            [self setAlphaWhenViewDocked:view andAlpha:0];
            viewDocked = YES;
        }
    }
    else
    {
        if (viewDocked)
        {
            [animator removeBehavior:snap];
            [self setAlphaWhenViewDocked:view andAlpha:1];
            viewDocked = NO;
        }
    }
}

- (void)bounce: (UIView *)view
{
    if (viewBounced)
    {
        for (UIView *aView in views)
        {
            if (aView != view)
            {
                CGPoint vel = CGPointMake(0, arc4random_uniform(2000));
                UIDynamicItemBehavior *behavior = [self itemBehaviorForView:aView];
                [behavior addLinearVelocity:vel forItem:aView];
                [animator updateItemUsingCurrentState:aView];
            }
        }
        viewBounced = NO;
    }
}

- (void)setAlphaWhenViewDocked: (UIView *)view andAlpha: (float)alpha
{
    for (UIView *aView in views)
    {
        if (aView != view)
        {
            aView.alpha = alpha;
        }
    }
}

- (void)addVelocityToView: (UIView *)view andGesture: (UIPanGestureRecognizer *)gesture
{
    CGPoint vel = CGPointMake(0, [gesture velocityInView:self.view].y);
    UIDynamicItemBehavior *behavior = [self itemBehaviorForView:view];
    [behavior addLinearVelocity:vel forItem:view];
}

- (void)handlePan: (UIPanGestureRecognizer *)gesture
{
    CGPoint touchPoint = [gesture locationInView:self.view];
    UIView *draggedView = gesture.view;
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint dragStartLocation = [gesture locationInView:draggedView];
        if (dragStartLocation.y < 200)
        {
            draggingView = YES;
            previousTouchPoint = touchPoint;
        }
    }
    else if (gesture.state == UIGestureRecognizerStateChanged && draggingView)
    {
        CGFloat yOffset = previousTouchPoint.y - touchPoint.y;
        draggedView.center = CGPointMake(draggedView.center.x, draggedView.center.y - yOffset);
        previousTouchPoint = touchPoint;
    }
    else if (gesture.state == UIGestureRecognizerStateEnded && draggingView)
    {
        [self addVelocityToView:draggedView andGesture:gesture];
        [animator updateItemUsingCurrentState:draggedView];
        draggingView = NO;
        viewBounced = YES;
        [self tryDockView:draggedView];
    }
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSString *stringIdentifier = (NSString *)identifier;
    if ([@"1" isEqualToString:stringIdentifier])
    {
        [self bounce:(UIView *)item];
    }
    else if ([@"2" isEqualToString:stringIdentifier])
    {
        [self tryDockView:(UIView *)item];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
