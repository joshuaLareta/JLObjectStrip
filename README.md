JLObjectStrip
=========================


A class that will convert custom NSObject and its property to JSON compatible object (Dictionary or Array).



Properties
----------
* ```JLObjectStrip.attrSkipList```
      * List of attribute/property names that wants to be skipped during the conversion 
      * usage: ```instance.attrSkipList = [NSMutableArray arrayWithObjects:@"property1",@"property2", nil];```
* ```JLObjectStrip.objectTypeChange```
      * Dictionary with values for the desired type (``float``,``double``,``int``,``longlong``)
      * Enum values : ```KObjectParserToInteger```,```KObjectParserToFloat```,```KObjectParserToDouble```,```KObjectParserToLong```
      * Usage: ```instance.objectTypeChange = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:KObjectParserToInteger] forKey:@"oldPropertyName"];```
* ```JLObjectStrip.attributeNamingMask```
      * Dictionary with values for the attribute/property name change
      * usage:```instance.attributeNamingMask =  [NSMutableDictionary dictionaryWithObject:@"newPropertyName" forKey:@"oldPropertyName"];```

Usage
------

1) Include the JLObjectStrip.h to your project.

2) Instantiate a new ```JLObjectStrip *instance = [JLObjectStrip new];``` object.

3) Call ```id processedNSObject = [instance disassembleNSObject:object]```

4) ```processedNSObject``` can now be used for JSON conversion 


Example:

Custom NSObject with different property type
```
@implementation sampleTest
@synthesize testProperty1;
@synthesize testProperty2;
@synthesize testProperty3;

-(id)init{
    self = [super init];
    if(self){
        
        self.testProperty1 = @"test1";
        self.testProperty2 = [NSMutableDictionary dictionaryWithObject:@"test" forKey:@"testDictionary"];
        
        self.testProperty3 = [NSMutableArray arrayWithObject:self.testProperty2];
    }
    return self;
}

```

Output using ``JLObjectStrip``:

```
 {
    testProperty1 = test1;
    testProperty2 =     {
        testDictionary = test;
    };
    testProperty3 =     (
                {
            testDictionary = test;
        }
    );
}
```

Credits
-------
I'd appreciate it to mention the use of this code in your project. On a website, in an about page, in the app itself, whatever. Or let me know by email or through github. It's nice to know where that it is being used.

Note
----

* `Must always skip delegate and UIViewcontroller`
* `Must enable ARC`
