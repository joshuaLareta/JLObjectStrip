//
//  JLCustomClassDisassembler.h
//
//  Created by Joshua Lareta


/*
The MIT License (MIT)

Copyright (c) 2013 Joshua Lareta

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/

//Can change Associative name of a dictionary by assigning a dictionary containing a the reference list


// MUST SKIP DELEGATE AND VIEWCONTROLLERS
#import <Foundation/Foundation.h>
typedef enum {
    KObjectParserToInteger = 0,
    KObjectParserToFloat = 1,
    KObjectParserToDouble = 2,
    KObjectParserToLong = 3,
}KObjectParserDataType;

@interface JLCustomClassDisassembler : NSObject {
}

/*
 
 add value to change the current property name of an object
 ex. test.property1 => test.changeproperty1
 [attributeNamingMask setObject@"NewAttributeName" forKey:@"currentAttributeName"];

 */
@property(nonatomic,strong)NSMutableDictionary *attributeNamingMask;

/*

 add value to change the current datatype for the given property name
 ex. [objectTypeChange setValue:KObjectParserToInteger forKey:@"property1"];
 
 */
@property(nonatomic,strong)NSMutableDictionary *objectTypeChange;

/*

 add value to skip the attribute in the list
 ex. [attrSkipList addObject:@"attributeToSkip"];

 */
@property(nonatomic,strong)NSMutableArray *attrSkipList;
 

/*
 
 Starts the process of disassembling
 
 */
-(id )disassembleNSObject:(id)_ObjectInstance;

@end
