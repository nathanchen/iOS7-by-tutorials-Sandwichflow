//
//  Sandwich.h
//  SandwichFlow
//
//  Created by Nate on 16/03/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sandwich : NSObject

@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) NSString *imageNamed;
@property (nonatomic, weak) NSMutableArray *keywords;
@property (nonatomic, weak) NSMutableArray *instructions;

@end
