//
//  ListUsersViewController.h
//  41-44 Homework CoreData
//
//  Created by Vladimir on 08.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course+CoreDataClass.h"
#import "CourseEditViewController.h"

@interface ListUsersViewController : UIViewController

@property (assign, nonatomic) BOOL isInstructorSelect;
@property (strong, nonatomic) CourseEditViewController* courseEditVC;

@end
