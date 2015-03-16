//
//  CollectionViewLabelCell.m
//  SandwichFlow
//
//  Created by Nate on 14/03/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "CollectionViewLabelCell.h"

@implementation CollectionViewLabelCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 3, 3)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_titleLabel];
    
    [self.layer setCornerRadius:5];
    [self.layer setMasksToBounds:YES];
    [self.layer setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1].CGColor];
    
    return self;
}

@end
