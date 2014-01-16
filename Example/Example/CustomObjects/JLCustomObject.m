//
//  JLCustomObject.m
//  Example
//
//  Created by Joshua on 15/1/14.
//  Copyright (c) 2014 Joshua. All rights reserved.
//

#import "JLCustomObject.h"

@implementation JLCustomObject
@synthesize  thisIsPropertyOne = _thisIsPropertyOne; // string
@synthesize  thisIsPropertyTwo = _thisIsPropertyTwo;// dictionary
@synthesize thisIsPropertyThree = _thisIsPropertyThree; // bool
@synthesize ThisIsPropertyFour = _ThisIsPropertyFour;// int
@synthesize thisIsPropertyFive = _thisIsPropertyFive;// array
@synthesize thisIsPropertySix = _thisIsPropertySix;// uiview


-(id)init{
    self = [super init];
    if(self){
        _thisIsPropertyOne = @"This is property one as a String";
        _thisIsPropertyTwo = [@{@"property2": @"This is property two as a dicitonary"} mutableCopy];
        _thisIsPropertyThree = YES;
        _ThisIsPropertyFour = @"10001";
        _thisIsPropertyFive = [@[@"this",@"is",@"property",@"five",@"as",@"an",@"array"]mutableCopy];
        _thisIsPropertySix = [UIView new];
    }
    return self;
}

@end
