//
//  JLMainViewController.m
//  Example
//
//  Created by Joshua on 15/1/14.
//  Copyright (c) 2014 Joshua. All rights reserved.
//

#import "JLMainViewController.h"
#import "JLCustomObject.h"
#import "JLCustomClassDisassembler.h"

@interface JLMainViewController ()

@end

@implementation JLMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    JLCustomObject *customObject = [JLCustomObject new];
    
    JLCustomClassDisassembler *disassembler = [JLCustomClassDisassembler new];
    
    
/*
     
 Uncomment any the attributes of disassembler to see how it works.

     
*/
    
    //Uncomment to see how attributeNamingMask work
    // This will change "propertyTwo" to "two" as the key
    
//    disassembler.attributeNamingMask = [@{@"thisIsPropertyTwo": @"two"}mutableCopy];
    
    //Uncomment  to see how to skip an attribute/property
    //This will skip any property you specify
//    disassembler.attrSkipList = [@[@"thisIsPropertyTwo"]mutableCopy];
    
    
    //uncomment to see how to change datatype
    //this will convert propertyfour which is a string to an INT data type
    
//    disassembler.objectTypeChange = [@{@"ThisIsPropertyFour":[NSNumber numberWithInt:KObjectParserToInteger]}mutableCopy];
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
    label.text = @"Output:";
    
    
    
    [self.view addSubview:label];
    
    
    UILabel *output = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 320,350)];
    output.text = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:[disassembler disassembleNSObject:customObject] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    output.numberOfLines = 0;
    output.font = [UIFont systemFontOfSize:12.0];
    output.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:output];
    
   
    
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
