//
//  SandwichViewController.m
//  SandwichFlow
//
//  Created by Nate on 14/03/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "SandwichViewController.h"

@interface SandwichViewController ()

@end

@implementation SandwichViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background-LowerLayer"]];
    background.alpha = 0.5;
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    
    [_keywordCollectionView registerClass:[CollectionViewLabelCell class] forCellWithReuseIdentifier:@"cell"];
    _keywordCollectionView.dataSource = self;
    _keywordCollectionView.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) _keywordCollectionView.collectionViewLayout;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(120, 20);
    
    [self updateControlsWithYummySandwichData];
}

- (void)updateControlsWithYummySandwichData
{
    NSString *imageName = [_sandwich valueForKey:@"image"];
    UIImage *image = [UIImage imageNamed:imageName];
    _imageView.image = image;
    
    _navigationBar.topItem.title = [_sandwich valueForKey:@"title"];
    NSArray *instructions = [_sandwich valueForKey:@"instructions"];
    _instructionTextView.text = [instructions componentsJoinedByString:@"\n\n"];
}

- (IBAction)closeButtonTapper:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_keywords count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = _keywords[indexPath.row];
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
