//
//  CourseEditViewController.m
//  41-44 Homework CoreData
//
//  Created by Vladimir on 07.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import "CourseEditViewController.h"
#import "EditCourseCell.h"
#import "DataManager.h"
#import "ListUsersViewController.h"
#import "UserEditViewController.h"

typedef enum {
    
    CourseInfoSection,
    StudentsSection
    
} CellSections;

typedef enum {
    
    CourseTitleRow,
    CourseTopicRow,
    SubjectRow,
    InstructorRow
    
} CellsRow;

@interface CourseEditViewController ()

@property (strong, nonatomic) EditCourseCell *courseTitleCell;
@property (strong, nonatomic) EditCourseCell *courseTopicCell;
@property (strong, nonatomic) EditCourseCell *subjectCell;
@property (strong, nonatomic) EditCourseCell *instructorCell;

@end

@implementation CourseEditViewController


- (NSManagedObjectContext*) managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[[DataManager sharedManager] persistentContainer] viewContext];
    }
    return _managedObjectContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.instructor) {
        self.instructor = self.course.instructor != nil ? self.course.instructor : self.instructor;
    }
    
    if (!self.students) {
        self.students = [NSMutableSet set];
        self.students = self.course.students != nil ? [NSMutableSet setWithSet:self.course.students] : self.students;
    }
    
    if (!self.course) {
        self.navItem.title = @"New Course";
    }
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark private methods
// show Alert With Title
- (void) showAlertWithTitle: (NSString*) title andMessage: (NSString*) message {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}


- (NSInteger) calculateIndexPathRowForStudents: (NSInteger) indexPathRow {
    return indexPathRow - 1;
}

- (BOOL) isAddStudentRow: (NSInteger) rowNumber {
    return rowNumber == 0;
}


#pragma mark - Action
- (IBAction)doneButtonAction:(UIBarButtonItem *)sender {
    
    if ([self.courseTitleCell.courseTitleField.text isEqual: @""] || self.courseTitleCell.courseTitleField.text == nil) {
        [self showAlertWithTitle:@"Enter a valid course title" andMessage:nil];
        
    } else if ([self.courseTopicCell.courseTopicField.text isEqual: @""] || self.courseTopicCell.courseTopicField.text == nil) {
        [self showAlertWithTitle:@"Enter a valid course topic" andMessage:nil];
        
    } else if ([self.subjectCell.subjectField.text isEqual: @""] || self.subjectCell.subjectField.text == nil) {
        [self showAlertWithTitle:@"Enter a valid subject" andMessage:nil];
        
    } else if (self.course) {
        
        self.course.courseTitle = self.courseTitleCell.courseTitleField.text;
        self.course.courseTopic = self.courseTopicCell.courseTopicField.text;
        self.course.subject = self.subjectCell.subjectField.text;
        self.course.instructor = self.instructor;
        self.course.students = self.students;
        
        NSError* error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%@", [error localizedDescription]);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        [[DataManager sharedManager] addCourseWithCourseTitle:self.courseTitleCell.courseTitleField.text
                                                  courseTopic:self.courseTopicCell.courseTopicField.text
                                                      subject:self.subjectCell.subjectField.text
                                                   instructor:self.instructor
                                                     students:self.students];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == CourseInfoSection) {
        return @"Course Info";
    } else {
        return @"Students";
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == CourseInfoSection) {
        return 4;
    } else {
        return self.students.count+1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* courseTitleCellIdentifier = @"courseTitleCell";
    static NSString* courseTopicCellIdentifier = @"courseTopicCell";
    static NSString* subjectCellIdentifier = @"subjectCell";
    static NSString* instructorCellIdentifier = @"instructorCell";
    
    static NSString* addStudentCellIdentifier = @"addStudentCellIdentifier";
    static NSString* studentCellIdentifier = @"studentCellIdentifier";
    
    if (indexPath.section == CourseInfoSection && indexPath.row == CourseTitleRow) {
        
        self.courseTitleCell = [tableView dequeueReusableCellWithIdentifier:courseTitleCellIdentifier forIndexPath:indexPath];
        if (self.course) {
            self.courseTitleCell.courseTitleField.text = self.course.courseTitle;
        }
        return self.courseTitleCell;
        
    } else if (indexPath.section == CourseInfoSection && indexPath.row == CourseTopicRow) {
        
        self.courseTopicCell = [tableView dequeueReusableCellWithIdentifier:courseTopicCellIdentifier forIndexPath:indexPath];
        if (self.course) {
            self.courseTopicCell.courseTopicField.text = self.course.courseTopic;
        }
        return self.courseTopicCell;
        
    } else if (indexPath.section == CourseInfoSection && indexPath.row == SubjectRow) {
        
        self.subjectCell = [tableView dequeueReusableCellWithIdentifier:subjectCellIdentifier forIndexPath:indexPath];
        if (self.course) {
            self.subjectCell.subjectField.text = self.course.subject;
        }
        return self.subjectCell;
        
    } else if (indexPath.section == CourseInfoSection && indexPath.row == InstructorRow) {
        
        self.instructorCell = [tableView dequeueReusableCellWithIdentifier:instructorCellIdentifier forIndexPath:indexPath];
        
        if (self.instructor) {
            self.instructorCell.instructorField.text = [NSString stringWithFormat:@"%@ %@", self.instructor.firstName, self.instructor.lastName];
        } else {
            self.instructorCell.instructorField.text = @"";
        }
        return self.instructorCell;
        
    } else if (indexPath.section == StudentsSection && [self isAddStudentRow:indexPath.row]) {
        
        UITableViewCell* addStudentCell = [tableView dequeueReusableCellWithIdentifier:addStudentCellIdentifier];
        if (!addStudentCell) {
            
            addStudentCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addStudentCellIdentifier];
            addStudentCell.textLabel.text = @"Add Students";
            addStudentCell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        return addStudentCell;
        
    } else {
        
        UITableViewCell* studentCell = [tableView dequeueReusableCellWithIdentifier:studentCellIdentifier];
        if (!studentCell) {
            studentCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentCellIdentifier];
            studentCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        NSSortDescriptor* firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
        NSSortDescriptor* lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
        NSArray* students = [self.students sortedArrayUsingDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
        
        User* student = [students objectAtIndex:[self calculateIndexPathRowForStudents:indexPath.row]];
        studentCell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        studentCell.detailTextLabel.text = student.email;
        
        return studentCell;
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == StudentsSection) {
        return YES;
    } else {
        return NO;
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        User* student = [[self.students allObjects] objectAtIndex:[self calculateIndexPathRowForStudents:indexPath.row]];
        [self.students removeObject:student];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}


#pragma mark - UITableViewDelegate
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == CourseInfoSection) {
        return NO;
    } else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == StudentsSection) {
        
        if ([self isAddStudentRow:indexPath.row]) {
            ListUsersViewController* vc = [[ListUsersViewController alloc] init];
            vc.courseEditVC = self;
            [self presentViewController:vc animated:YES completion:nil];
            
        } else {
            User* student = [[self.students allObjects] objectAtIndex:[self calculateIndexPathRowForStudents:indexPath.row]];
            UserEditViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UserEditViewController"];
            vc.user = student;
            
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.instructorCell.instructorField]) {
        
        ListUsersViewController* vc = [[ListUsersViewController alloc] init];
        vc.isInstructorSelect = YES;
        vc.courseEditVC = self;
        [self presentViewController:vc animated:YES completion:nil];
        
        return NO;
        
    } else {
        return YES;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.courseTitleCell.courseTitleField]) {
        [self.courseTopicCell.courseTopicField becomeFirstResponder];
        
    } else if ([textField isEqual:self.courseTopicCell.courseTopicField]) {
        [self.subjectCell.subjectField becomeFirstResponder];
        
    } else if ([textField isEqual:self.subjectCell.subjectField]) {
        [self.instructorCell.instructorField becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}


@end
