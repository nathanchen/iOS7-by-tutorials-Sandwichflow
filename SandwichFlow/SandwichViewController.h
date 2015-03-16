//
//  SandwichViewController.h
//  SandwichFlow
//
//  Created by Nate on 14/03/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewLabelCell.h"
#import "Sandwich.h"

@interface SandwichViewController : UIViewController<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UICollectionView *keywordCollectionView;
@property (weak, nonatomic) IBOutlet UITextView *instructionTextView;

@property (nonatomic, weak) Sandwich *sandwich;
@property (nonatomic, weak) NSMutableArray *keywords;

- (IBAction)closeButtonTapper:(id)sender;


@end
