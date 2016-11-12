//
//  UserEditViewController.h
//  41-44 Homework CoreData
//
//  Created by Vladimir on 05.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "User+CoreDataClass.h"

@interface UserEditViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) User* user;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
- (IBAction)doneButtonAction:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender;

@end
