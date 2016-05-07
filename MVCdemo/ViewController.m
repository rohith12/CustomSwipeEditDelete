//
//  ViewController.m
//  MVCdemo
//
//  Created by Rohith on 03/05/16.
//  Copyright © 2016 rohith. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSIndexPath* selectedpath;
@property(nonatomic,assign)BOOL flag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.modelObjects=[[NSMutableArray alloc] init];
    
//   NSArray* array =[self fetchForCheck];
//    
//   
//    NSManagedObjectContext* context=[self getContext];
//    NSManagedObject* emp=[NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
//    [emp setValue:@"rahgavendra" forKey:@"name"];
//    [emp setValue:@"IOS" forKey:@"designation"];
    
    
//    for (NSManagedObject* empLocal in array) {
//        
//        if ([[empLocal valueForKey:@"name"] isEqualToString:[emp valueForKey:@"name"]]) {
//            self.flag=true;
//        }else{
//            self.flag=false;
//        }
//        
//        
//    }
    
    
   
    
        [self fetchData];
    
//    else{
//        NSError* error=nil;
//        if ([context save:&error]) {
//            [self fetchData];
//        }
//    }
    
    
    
    
    
//    EmpolyeeModel* ragh=[[EmpolyeeModel alloc] initWithName:@"rahgavendra" Designation:@"IOS"];
//     EmpolyeeModel* bhaskar=[[EmpolyeeModel alloc] initWithName:@"bhaskar" Designation:@"IOS"];
//     EmpolyeeModel* meha=[[EmpolyeeModel alloc] initWithName:@"meha" Designation:@"IOS"];
//     EmpolyeeModel* bhagyashre=[[EmpolyeeModel alloc] initWithName:@"bhagyashre" Designation:@"IOS"];
//    EmpolyeeModel* harish=[[EmpolyeeModel alloc] initWithName:@"harish" Designation:@"IOS"];
//    
//    [self.modelObjects addObjectsFromArray:@[ragh,bhaskar,meha,bhagyashre,harish]];

    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)fetchData{
    
    NSManagedObjectContext* context=[self getContext];
    NSFetchRequest* req=[[NSFetchRequest alloc] initWithEntityName:@"Employee"];
    NSError* error=nil;
    
    self.modelObjects=[[NSMutableArray alloc] initWithArray:[context executeFetchRequest:req error:&error]];
    [self.tableview reloadData];
   // [self.modelObjects addObjectsFromArray:];
}

-(NSArray*)fetchForCheck{
    NSManagedObjectContext* context=[self getContext];
    NSFetchRequest* req=[[NSFetchRequest alloc] initWithEntityName:@"Employee"];
    NSError* error=nil;
    
    NSArray* array=[[NSMutableArray alloc] initWithArray:[context executeFetchRequest:req error:&error]];
    return array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.modelObjects.count;
}
- (IBAction)Add:(id)sender {
    
    UIAlertController* controller=[UIAlertController alertControllerWithTitle:@"Add Employee" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder=@"Enter Name";
        
    }];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"Enter Designation";
    }];
    
    
    UIAlertAction* alertaction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        UITextField* name = [controller.textFields objectAtIndex:0];
        
        UITextField* des = [controller.textFields objectAtIndex:1];
        
        
        NSManagedObjectContext* context=[self getContext];
        NSManagedObject* emp=[NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
        [emp setValue:name.text forKey:@"name"];
        [emp setValue:des.text forKey:@"designation"];
        NSError* error=nil;
        
        if ([context save:&error]) {
            [self fetchData];
        }
//        EmpolyeeModel* model = [[EmpolyeeModel alloc] initWithName:name.text Designation:des.text];
//        [self.modelObjects addObject:model];
//        
//        [self.tableview reloadData];
//
        
        
        
    }];
    [controller addAction:alertaction];
    
    [self presentViewController:controller animated:YES completion:nil];

    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSManagedObject *model=self.modelObjects[indexPath.row];
    
    cell.empName.text=[model valueForKey:@"name"];
    cell.Empdesignation.text=[model valueForKey:@"designation"];
    return cell;
    
    
    
}


- (IBAction)edit:(UIButton*)sender {
    
    NSManagedObject* model = self.modelObjects[self.selectedpath.row];
    
    
    UIAlertController* controller=[UIAlertController alertControllerWithTitle:@"Add Employee" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text=[model valueForKey:@"name"];
        
    }];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text=[model valueForKey:@"designation"];
    }];
    
    
    UIAlertAction* alertaction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        UITextField* name = [controller.textFields objectAtIndex:0];
        
        UITextField* des = [controller.textFields objectAtIndex:1];
        
         NSIndexPath *indexPath = [self.tableview indexPathForCell:(TableViewCell *)sender.superview.superview];
        
        [model setValue:name.text forKey:@"name"];
        [model setValue:des.text forKey:@"designation"];
        
        NSManagedObjectContext* context=[self getContext];
        NSError* error=nil;
        [context save:&error];
        
        
//        EmpolyeeModel* model = [[EmpolyeeModel alloc] initWithName:name.text Designation:des.text];
//        [self.modelObjects replaceObjectAtIndex:indexPath.row withObject:model];
        TableViewCell* cell = [self.tableview cellForRowAtIndexPath:indexPath];
        cell.editBtn.hidden=YES;
        cell.deleteBtn.hidden=YES;
        [self fetchData];
        //[self.tableview reloadData];
       
        
        
    }];
    [controller addAction:alertaction];
    
    [self presentViewController:controller animated:YES completion:nil];
    
    
}

- (IBAction)delete:(UIButton*)sender {
    
    
     NSIndexPath *indexPath = [self.tableview indexPathForCell:(TableViewCell *)sender.superview.superview];
    
    NSManagedObjectContext *context=[self getContext];
    [context deleteObject:[self.modelObjects objectAtIndex:indexPath.row]];
    NSError* error=nil;
    [context save:&error];
    
    [self.modelObjects removeObjectAtIndex:indexPath.row];
    TableViewCell* cell = [self.tableview cellForRowAtIndexPath:indexPath];
    cell.editBtn.hidden=YES;
    cell.deleteBtn.hidden=YES;
    [self.tableview reloadData];
   
}

- (IBAction)left:(UIGestureRecognizer*)sender {
    
    CGPoint loc=[sender locationInView:self.tableview];
    self.selectedpath = [self.tableview indexPathForRowAtPoint:loc];
    TableViewCell* cell = [self.tableview cellForRowAtIndexPath:self.selectedpath];
    cell.editBtn.hidden=NO;
    cell.deleteBtn.hidden=NO;
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"hide" object:nil];
    
    
}

- (IBAction)right:(UIGestureRecognizer*)sender {
    
    CGPoint location=[sender locationInView:self.tableview];
    NSIndexPath* path = [self.tableview indexPathForRowAtPoint:location];
    TableViewCell* cell = [self.tableview cellForRowAtIndexPath:path];
    cell.editBtn.hidden=YES;
    cell.deleteBtn.hidden=YES;
}


-(NSManagedObjectContext*)getContext{
    AppDelegate* app=[UIApplication sharedApplication].delegate;
    NSManagedObjectContext* context=[app managedObjectContext];
    return context;
}


@end
