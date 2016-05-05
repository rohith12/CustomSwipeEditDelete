//
//  EmpolyeeModel.h
//  MVCdemo
//
//  Created by Rohith on 03/05/16.
//  Copyright © 2016 rohith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmpolyeeModel : NSObject
@property(nonatomic,strong)NSString* NameEmp;
@property(nonatomic,strong)NSString* designationEmp;
- (instancetype)initWithName:(NSString*)eName Designation:(NSString*)design;
@end
