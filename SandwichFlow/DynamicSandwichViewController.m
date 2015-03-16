//
//  DynamicSandwichViewController.m
//  SandwichFlow
//
//  Created by Nate on 16/03/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "DynamicSandwichViewController.h"

@interface DynamicSandwichViewController ()
{
    NSMutableArray *views;
}

@end

@implementation DynamicSandwichViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background-LowerLayer"]];
    [self.view addSubview:backgroundImageView];
    
    UIImageView *header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Sarnie"]];
    header.center = CGPointMake(220, 190);
    [self.view addSubview:header];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIView *)addReciptAtOffset: (CGFloat)offset

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
