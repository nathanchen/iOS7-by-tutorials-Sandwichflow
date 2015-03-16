//
//  SandwichesViewController.m
//  SandwichFlow
//
//  Created by Nate on 15/03/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "SandwichesViewController.h"

@interface SandwichesViewController ()

@end

@implementation SandwichesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UIImageView *header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Sarnie"]];
    header.center = CGPointMake(220, 190);
    [headerView addSubview:header];
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background-LowerLayer"]];
}

- (NSMutableArray *)sandwiches
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    return appDelegate.sandwiches;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SandwichViewController *sandwichVS = segue.destinationViewController;
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
//    sandwichVS.sandwich = [self sandwiches][path.row];
    sandwichVS.sandwich = [[self sandwiches] objectAtIndex:path.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self sandwiches] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    Sandwich *sandwich = [[self sandwiches] objectAtIndex:indexPath.row];
    cell.textLabel.text = sandwich.title;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
