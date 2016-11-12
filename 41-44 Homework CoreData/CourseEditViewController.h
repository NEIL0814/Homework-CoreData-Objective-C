//
//  CourseEditViewController.h
//  41-44 Homework CoreData
//
//  Created by Vladimir on 07.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Course+CoreDataClass.h"
#import "User+CoreDataClass.h"

@interface CourseEditViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Course* course;
@property (strong, nonatomic) User* instructor;
@property (strong, nonatomic) NSMutableSet<User *> *students;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
- (IBAction)doneButtonAction:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender;

@end
