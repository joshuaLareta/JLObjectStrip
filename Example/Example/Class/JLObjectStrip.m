//
//  JLObjectStrip.m
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

#import "JLObjectStrip.h"
#import <objC/runtime.h>
@implementation JLObjectStrip
@synthesize attributeNamingMask;
@synthesize attrSkipList;
@synthesize objectTypeChange;
#pragma mark - Public Interface



-(id)init{
    self = [super init];
    if(self){
        self.attributeNamingMask = [NSMutableDictionary new];
        self.attrSkipList = [NSMutableArray new];
        self.objectTypeChange = [NSMutableDictionary new];
    }
    return self;
}


// STARTS THE PROCESS OF DISASSEMBLE
-(id )disassembleNSObject:(id)_ObjectInstance{

    
    id NSObjectInstance;
    if([_ObjectInstance isKindOfClass:[NSMutableDictionary class]] ||
       [_ObjectInstance isKindOfClass:[NSDictionary class]] ||
       [_ObjectInstance isKindOfClass:[NSMutableArray class]] ||
       [_ObjectInstance isKindOfClass:[NSArray class]]){
        
        NSObjectInstance = [self loopObject:_ObjectInstance];
        
    }else{
    
        NSObjectInstance = [self getClassProperties:_ObjectInstance];
    }
    return NSObjectInstance;
}





#pragma mark - private functions

//Loop objects and get the details 
-(id)loopObject:(id)obj{
    
    id processedFinalObj; //= [NSMutableDictionary new];
    if([obj isKindOfClass:[NSMutableArray class]] ||
       [obj isKindOfClass:[NSArray class]]){
       
        processedFinalObj = [NSMutableArray new];
    }
    else if([obj isKindOfClass:[NSMutableDictionary class]] ||
            [obj isKindOfClass:[NSDictionary class]]){
        
        processedFinalObj = [NSMutableDictionary new];
    }

    for(id objPropertyName in obj){
        if([objPropertyName isKindOfClass:[NSMutableArray class]] ||
           [objPropertyName isKindOfClass:[NSArray class]]){
            
            [processedFinalObj addObject:[self loopObject:objPropertyName]];
        }
        else if([objPropertyName isKindOfClass:[NSMutableDictionary class]] ||
                [objPropertyName isKindOfClass:[NSDictionary class]]){
            
                    [processedFinalObj addObject:[self loopObject:objPropertyName]];
            
            
        }
        
        else if([objPropertyName isKindOfClass:[NSString class]]){
  		if ([obj isKindOfClass:[NSMutableArray class]] ||
                [obj isKindOfClass:[NSArray class]]) {
                
				[processedFinalObj addObject:objPropertyName];
			} else {
                
                
            id objProcessed = [obj valueForKey:objPropertyName];
           
            if([objProcessed isKindOfClass:[NSMutableDictionary class]] ||
               [objProcessed isKindOfClass:[NSDictionary class]] ||
               [objProcessed isKindOfClass:[NSMutableArray class]] ||
               [objProcessed isKindOfClass:[NSArray class]]){
              
                if([obj isKindOfClass:[NSMutableArray class]] ||
                   [obj isKindOfClass:[NSArray class]]){
                    
                    [processedFinalObj addObject:[self loopObject:objProcessed]];
                }
                else if([obj isKindOfClass:[NSMutableDictionary class]] ||
                        [obj isKindOfClass:[NSDictionary class]]){
					//Check the reference of the dictionary
                    
                    
                    if(![self.attrSkipList containsObject:objPropertyName]){
                        NSString* referencePropertyName = [self.attributeNamingMask valueForKey:objPropertyName]==nil?objPropertyName : [self.attributeNamingMask valueForKey:objPropertyName];
                        [processedFinalObj setObject:[self loopObject:objProcessed] forKey:referencePropertyName];
                    }

                }
                
                

            }
            else if([objProcessed isKindOfClass:[NSString class]]){
                if(![self.attrSkipList containsObject:objPropertyName]){
                    NSString* referencePropertyName = [self.attributeNamingMask valueForKey:objPropertyName]==nil?objPropertyName : [self.attributeNamingMask valueForKey:objPropertyName];
                    [processedFinalObj setObject:objProcessed forKey:referencePropertyName];
                }

            }
			else if([objProcessed isKindOfClass:[NSNumber class]]){
                if(![self.attrSkipList containsObject:objPropertyName]){
                    NSString* referencePropertyName = [self.attributeNamingMask valueForKey:objPropertyName]==nil?objPropertyName : [self.attributeNamingMask valueForKey:objPropertyName];
                    
                    if([[self.objectTypeChange allKeys]containsObject:objPropertyName]){
                        NSInteger objectToType = [[self.objectTypeChange valueForKey:objPropertyName] integerValue];
                        
                        
                        if(objectToType  == KObjectParserToFloat){
                            objProcessed = [NSNumber numberWithFloat:[objProcessed floatValue]];
                        }
                        else if(objectToType == KObjectParserToInteger){
                            objProcessed = [NSNumber numberWithInt:[objProcessed intValue]];
                        }
                        else if(objectToType == KObjectParserToDouble){
                            objProcessed = [NSNumber numberWithDouble:[objProcessed doubleValue]];
                        }
                        else if(objectToType == KObjectParserToLong){
                            objProcessed = [NSNumber numberWithLongLong:[objProcessed longLongValue]];
                        }
                        
                    }
                    [processedFinalObj setObject:objProcessed forKey:referencePropertyName];
                }
				
            }
            else{
                
                if(![self.attrSkipList containsObject:objPropertyName]){
                    NSString* referencePropertyName = [self.attributeNamingMask valueForKey:objPropertyName]==nil?objPropertyName : [self.attributeNamingMask valueForKey:objPropertyName];
                    [processedFinalObj setObject:[self disassembleNSObject:objProcessed] forKey:referencePropertyName];
                }

            }

            }
        }
        else{
            if([obj isKindOfClass:[NSMutableArray class]] ||
               [obj isKindOfClass:[NSArray class]]){
                id objItem = [self disassembleNSObject:objPropertyName];
                if(objItem != nil)
                    [processedFinalObj addObject: objItem];
                
            }
            else if([obj isKindOfClass:[NSMutableDictionary class]] ||
                    [obj isKindOfClass:[NSDictionary class]]){
				
				//Check the reference of the dictionary
                if(![self.attrSkipList containsObject:objPropertyName]){
                    
                    NSString* referencePropertyName = [self.attributeNamingMask valueForKey:objPropertyName]==nil?objPropertyName : [self.attributeNamingMask valueForKey:objPropertyName];
                    [processedFinalObj setObject:[self disassembleNSObject:objPropertyName] forKey:referencePropertyName];
                }
				
            }
        }
    }

    return processedFinalObj;
}

-(BOOL)checkIfObjectIsNil:(id)objectToBeCheck{
    
    //check type before checking for count
    if([objectToBeCheck isKindOfClass:[NSMutableDictionary class]] ||
       [objectToBeCheck isKindOfClass:[NSDictionary class]] ||
       [objectToBeCheck isKindOfClass:[NSMutableArray class]] ||
       [objectToBeCheck isKindOfClass:[NSArray class]]){
        if([objectToBeCheck count]>0)
            return YES;
        else{
            return NO;
        }
    }
    //check if string and check length instead
    else if([objectToBeCheck isKindOfClass:[NSString class]]){
        if([objectToBeCheck length]>0)
            return YES;
        else
            return NO;
    }
    return YES;
}


//get Object from Custom class

-(id)getClassProperties:(id)obj{
    
    
  //must skip if its a view or a viewController
    if([[obj class]isSubclassOfClass:[UIView class]]||[[obj class]isSubclassOfClass:[UIViewController class]]){
        return [NSString stringWithFormat:@"%@",[obj class]];
    }
    
    //If its not an NSObject just return the class name of it
    if(![obj isKindOfClass:[NSObject class]]){
        return [NSString stringWithFormat:@"%@",[obj class]];
    }
    
    id mutatedObject;

    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([obj class], &propertyCount);

    for(unsigned int i = 0;i< propertyCount;i++){
        objc_property_t property = properties[i];
        const char * propertyAttrs = property_getAttributes(property);
       
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if(![self.attrSkipList containsObject:propertyName]){
            id objInstance = [obj valueForKey:propertyName];
            int chosenType = 999;
            id processedObj = nil;
            if([self checkIfObjectIsNil:objInstance]){
                if([[self.objectTypeChange allKeys]containsObject:propertyName]){
                    NSInteger objectToType = [[self.objectTypeChange valueForKey:propertyName] integerValue];
                   
                    
                    if(objectToType  == KObjectParserToFloat){
                        objInstance = [NSNumber numberWithFloat:[objInstance floatValue]];
                        chosenType = 1;
                    }
                    else if(objectToType == KObjectParserToInteger){
                        objInstance = [NSNumber numberWithInt:[objInstance intValue]];
                        chosenType = 0;
                    }
                    else if(objectToType == KObjectParserToDouble){
                        objInstance = [NSNumber numberWithDouble:[objInstance doubleValue]];
                        chosenType = 2;

                    }
                    else if(objectToType == KObjectParserToLong){
                        objInstance = [NSNumber numberWithLongLong:[objInstance longLongValue]];
                        chosenType = 3;

                    }
                    
                }
                processedObj = [self getObjectValue:objInstance];
            }
            if(processedObj){
                switch (propertyAttrs[1]) {
                    case 'c':
                        processedObj = [NSString stringWithFormat:@"%d",[processedObj intValue]];
                        break;
                    default:
                        break;
                }
                
                if(![self.attrSkipList containsObject:propertyName]){
                    NSString* referencePropertyName = [self.attributeNamingMask valueForKey:propertyName]==nil?propertyName : [self.attributeNamingMask valueForKey:propertyName];
                    
                    
                    if(chosenType == 0){//int
                        processedObj = [NSNumber numberWithInt:[processedObj intValue]];
                    }
                    else if(chosenType == 1){//float
                        processedObj = [NSNumber numberWithFloat:[processedObj floatValue]];
                    }
                    else if(chosenType == 2){
                        processedObj = [NSNumber numberWithDouble:[processedObj doubleValue]];
 
                    }
                    else if(chosenType == 3){
                        processedObj = [NSNumber numberWithLongLong:[processedObj longLongValue]];

                    }
                    if(mutatedObject == nil)
                        mutatedObject  = [NSMutableDictionary new];
                    
                    [mutatedObject setObject:processedObj forKey:referencePropertyName];
                }
                
            }
        }
        //if(![objInstance isKindOfClass:[NSNumber class]])
       // free(property);
    }
    
    free(properties);
    return mutatedObject;
}




//gets the most Detailed object value
-(id)getObjectValue:(id)obj{
    if([obj isKindOfClass:[NSString class]]){
        return obj;
    }
    else if([obj isKindOfClass:[NSNumber class]]){
        return [NSNumber numberWithDouble:[obj doubleValue]];
    }
    else if([obj isKindOfClass:[NSArray class]] ||
            [obj isKindOfClass:[NSMutableArray class]]){
        
        return [self loopObject:obj];
    }
    else if([obj isKindOfClass:[NSMutableDictionary class]] ||
            [obj isKindOfClass:[NSDictionary class]]){
        
        NSMutableDictionary *dictDepp1 = [NSMutableDictionary new];
        dictDepp1 = [self loopObject:obj];
        return dictDepp1;
    }
    else{
        if(obj != nil)
            return [self disassembleNSObject:obj];
    }
return nil;
}
@end
