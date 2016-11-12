//
//  Course+CoreDataProperties.m
//  41-44 Homework CoreData
//
//  Created by Vladimir on 07.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import "Course+CoreDataProperties.h"

@implementation Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Course"];
}

@dynamic courseTitle;
@dynamic courseTopic;
@dynamic subject;
@dynamic instructor;
@dynamic students;

@end
