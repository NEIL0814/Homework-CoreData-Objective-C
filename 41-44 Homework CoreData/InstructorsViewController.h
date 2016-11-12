//
//  InstructorsViewController.h
//  41-44 Homework CoreData
//
//  Created by Vladimir on 09.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Course+CoreDataClass.h"
#import "User+CoreDataClass.h"

@interface InstructorsViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController<Course *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
