//
//  EmpolyeeModel.m
//  MVCdemo
//
//  Created by Rohith on 03/05/16.
//  Copyright © 2016 rohith. All rights reserved.
//

#import "EmpolyeeModel.h"

@implementation EmpolyeeModel


- (instancetype)initWithName:(NSString*)eName Designation:(NSString*)design
{
    self = [super init];
    
    if (self) {
        
        self.NameEmp=eName;
        self.designationEmp=design;
        
    }
    
    return self;
}






@end
