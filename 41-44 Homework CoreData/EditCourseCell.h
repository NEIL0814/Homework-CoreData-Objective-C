//
//  EditCourseCell.h
//  41-44 Homework CoreData
//
//  Created by Vladimir on 07.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditCourseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *courseTitleField;
@property (weak, nonatomic) IBOutlet UITextField *courseTopicField;
@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UITextField *instructorField;

@end
