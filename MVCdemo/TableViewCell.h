//
//  TableViewCell.h
//  MVCdemo
//
//  Created by Rohith on 04/05/16.
//  Copyright © 2016 rohith. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *empName;
@property (weak, nonatomic) IBOutlet UILabel *Empdesignation;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@end
