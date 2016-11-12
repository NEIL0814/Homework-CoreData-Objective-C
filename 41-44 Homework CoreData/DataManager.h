//
//  DataManager.h
//  41-44 Homework CoreData
//
//  Created by Vladimir on 03.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "User+CoreDataClass.h"

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (DataManager*) sharedManager;
- (void)saveContext;

- (NSArray*) allUsers;
- (User*) addStudentWithFirstName: (NSString*) firstName lastName: (NSString*) lastName email: (NSString*) email;
- (Course*) addCourseWithCourseTitle: (NSString*) courseTitle courseTopic: (NSString*) courseTopic subject: (NSString*) subject instructor: (User*) instructor students: (NSSet<User *>*) students;

@end
