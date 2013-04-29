//
//  JLCustomClassDisassembler.h
//
//  Created by Joshua Lareta



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
