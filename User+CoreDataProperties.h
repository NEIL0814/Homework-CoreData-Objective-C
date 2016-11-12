//
//  User+CoreDataProperties.h
//  41-44 Homework CoreData
//
//  Created by Vladimir on 07.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import "User+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, retain) NSSet<Course *> *coursesForInstructor;
@property (nullable, nonatomic, retain) NSSet<Course *> *coursesForStudents;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCoursesForStudentsObject:(Course *)value;
- (void)removeCoursesForStudentsObject:(Course *)value;
- (void)addCoursesForStudents:(NSSet<Course *> *)values;
- (void)removeCoursesForStudents:(NSSet<Course *> *)values;

@end

NS_ASSUME_NONNULL_END
