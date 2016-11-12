//
//  Course+CoreDataProperties.h
//  41-44 Homework CoreData
//
//  Created by Vladimir on 07.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import "Course+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *courseTitle;
@property (nullable, nonatomic, copy) NSString *courseTopic;
@property (nullable, nonatomic, copy) NSString *subject;
@property (nullable, nonatomic, retain) User *instructor;
@property (nullable, nonatomic, retain) NSSet<User *> *students;

@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(User *)value;
- (void)removeStudentsObject:(User *)value;
- (void)addStudents:(NSSet<User *> *)values;
- (void)removeStudents:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
