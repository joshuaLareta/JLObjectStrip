//
//  JLCustomObject.h
//  Example
//
//  Created by Joshua on 15/1/14.
//  Copyright (c) 2014 Joshua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLCustomObject : NSObject
@property (nonatomic, strong) NSString *thisIsPropertyOne;
@property (nonatomic, strong) NSMutableDictionary *thisIsPropertyTwo;
@property (nonatomic, assign) BOOL thisIsPropertyThree;
@property (nonatomic, strong) NSString *ThisIsPropertyFour; // masked as a string but it is really an NSInteger value
@property (nonatomic, strong) NSMutableArray *thisIsPropertyFive;

@end
