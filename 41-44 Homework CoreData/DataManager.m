//
//  DataManager.m
//  41-44 Homework CoreData
//
//  Created by Vladimir on 03.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import "DataManager.h"
#import "Course+CoreDataClass.h"

@implementation DataManager

+ (DataManager*) sharedManager {
    
    static DataManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });
    return manager;
}


- (NSArray*) allUsers {
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.persistentContainer.viewContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];

    NSError* requestError = nil;
    NSArray* resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", requestError.description);
    }
    
    return resultArray;
}


- (User*) addStudentWithFirstName: (NSString*) firstName lastName: (NSString*) lastName email: (NSString*) email {
    
    User* user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.persistentContainer.viewContext];
    
    user.firstName = firstName;
    user.lastName = lastName;
    user.email = email;
    
    NSError* error = nil;
    if (![self.persistentContainer.viewContext save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
    return user;
}


- (Course*) addCourseWithCourseTitle: (NSString*) courseTitle courseTopic: (NSString*) courseTopic subject: (NSString*) subject instructor: (User*) instructor students: (NSSet<User *>*) students {
    
    Course* course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.persistentContainer.viewContext];
    
    course.courseTitle = courseTitle;
    course.courseTopic = courseTopic;
    course.subject = subject;
    course.instructor = instructor;
    course.students = students;
    
    NSError* error = nil;
    if (![self.persistentContainer.viewContext save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
    return course;
}

#pragma mark - Core Data stack
@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"_1_44_Homework_CoreData"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


@end
