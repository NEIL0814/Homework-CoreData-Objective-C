//
//  ListUsersViewController.m
//  41-44 Homework CoreData
//
//  Created by Vladimir on 08.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import "ListUsersViewController.h"
#import "User+CoreDataClass.h"
#import "DataManager.h"

@interface ListUsersViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView* tableView;

@end

@implementation ListUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 54, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-54) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UINavigationBar* navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.view.bounds), 44)];
    navBar.backgroundColor = [UIColor whiteColor];
    
    NSString* title = [self isInstructorSelect] ? @"Select Instructor" : @"Select Students";
    UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:title];
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                 target:self
                                                                                 action:@selector(doneButtonAction:)];
    navItem.rightBarButtonItem = buttonItem;
    navBar.items = @[navItem];
    [self.view addSubview:navBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action
- (void)doneButtonAction:(UIBarButtonItem *)sender {
    [self.courseEditVC.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DataManager sharedManager] allUsers] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* userCellIdentifierForList = @"userCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellIdentifierForList];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:userCellIdentifierForList];
    }
    
    User* user = [[[DataManager sharedManager] allUsers] objectAtIndex: indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    
    if (self.isInstructorSelect) {
        
        if ([self.courseEditVC.students containsObject:user]) {
            cell.detailTextLabel.text = @"Studies this course";
        } else {
            cell.detailTextLabel.text = [self.courseEditVC.instructor isEqual:user] ? @"✓" : @"";
        }
       
    } else {
        
        if ([self.courseEditVC.instructor isEqual:user]) {
            cell.detailTextLabel.text = @"Leads this course";
        } else {
            cell.detailTextLabel.text = [self.courseEditVC.students containsObject:user] ? @"✓" : @"";
        }
    }
    return cell;
}


#pragma mark - UITableViewDelegate
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User* user = [[[DataManager sharedManager] allUsers] objectAtIndex: indexPath.row];
    
    if (self.isInstructorSelect) {
        
        if ([self.courseEditVC.students containsObject:user]) {
            return nil;
        } else {
            return indexPath;
        }
        
    } else {
        
        if ([self.courseEditVC.instructor isEqual:user]) {
            return nil;
        } else {
            return indexPath;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    User* user = [[[DataManager sharedManager] allUsers] objectAtIndex: indexPath.row];
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.detailTextLabel.text isEqualToString:@"✓"]) {
        
        if (self.isInstructorSelect) {
            
            self.courseEditVC.instructor = nil;
            
        } else {
 
            [self.courseEditVC.students removeObject:user];
        }
        
        cell.detailTextLabel.text = @"";
        
    } else {
        
        if (self.isInstructorSelect) {
            
            self.courseEditVC.instructor = user;
            [tableView reloadData];
            
        } else {
 
            [self.courseEditVC.students addObject:user];
        }
        cell.detailTextLabel.text = @"✓";
    }
}

@end
