//
//  UserEditViewController.m
//  41-44 Homework CoreData
//
//  Created by Vladimir on 05.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import "UserEditViewController.h"
#import "CourseEditViewController.h"
#import "EditUserCell.h"
#import "DataManager.h"
#import "Course+CoreDataClass.h"

typedef enum {
    
    FirstNameRow,
    LastNameRow,
    EmailRow
    
} CellsRow;


@interface UserEditViewController ()

@property (strong, nonatomic) EditUserCell *firstNameCell;
@property (strong, nonatomic) EditUserCell *lastNameCell;
@property (strong, nonatomic) EditUserCell *emailCell;

@property (assign, nonatomic) NSInteger infoUserSection;
@property (assign, nonatomic) NSInteger coursesForInstructorsSection;
@property (assign, nonatomic) NSInteger coursesForStudentsSection;

@end

@implementation UserEditViewController

- (NSManagedObjectContext*) managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[[DataManager sharedManager] persistentContainer] viewContext];
    }
    return _managedObjectContext;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.user) {
        self.navItem.title = @"New User";
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


#pragma mark - Action
- (IBAction)doneButtonAction:(UIBarButtonItem *)sender {
    
    if ([self.firstNameCell.firstNameField.text isEqual: @""] || self.firstNameCell.firstNameField.text == nil) {
        [self showAlertWithTitle:@"Enter a valid first name" andMessage:nil];
        
    } else if ([self.firstNameCell.firstNameField.text isEqual: @""] || self.firstNameCell.firstNameField.text == nil) {
        [self showAlertWithTitle:@"Enter a valid last name" andMessage:nil];
        
    } else if ([self.firstNameCell.firstNameField.text isEqual: @""] || self.firstNameCell.firstNameField.text == nil) {
        [self showAlertWithTitle:@"Enter a valid email address" andMessage:nil];
        
    } else if (self.user) {
        
        self.user.firstName = self.firstNameCell.firstNameField.text;
        self.user.lastName = self.lastNameCell.lastNameField.text;
        self.user.email = self.emailCell.emailField.text;
        
        NSError* error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%@", [error localizedDescription]);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        [[DataManager sharedManager] addStudentWithFirstName:self.firstNameCell.firstNameField.text
                                                    lastName:self.lastNameCell.lastNameField.text
                                                       email:self.emailCell.emailField.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    self.infoUserSection = 0;
    NSInteger numberOfSections = 1;

    if (self.user.coursesForInstructor.count > 0) {
        self.coursesForInstructorsSection = numberOfSections;
        numberOfSections += 1;
    }
    if (self.user.coursesForStudents.count > 0) {
        self.coursesForStudentsSection = numberOfSections;
        numberOfSections += 1;
    }
    
    return numberOfSections;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == self.infoUserSection) {
        return @"";
        
    } else if (section == self.coursesForInstructorsSection) {
        return @"Leads Courses";
        
    } else {
        return @"Studies Courses";
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == self.infoUserSection) {
        return 3;
        
    } else if (section == self.coursesForInstructorsSection) {
        return self.user.coursesForInstructor.count;
        
    } else {
        return self.user.coursesForStudents.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* firstNameCellIdentifier = @"firstNameCell";
    static NSString* lastNameCellIdentifier = @"lastNameCell";
    static NSString* emailCellIdentifier = @"EmailCell";
    static NSString* CoursesForStudentsCellIdentifier = @"CoursesForStudentsCellIdentifier";
    static NSString* CoursesForInstructorsCellIdentifier = @"CoursesForInstructorsCellIdentifier";
    
    if (indexPath.section == self.infoUserSection && indexPath.row == FirstNameRow) {
        
        self.firstNameCell = [tableView dequeueReusableCellWithIdentifier:firstNameCellIdentifier forIndexPath:indexPath];
        if (self.user) {
            self.firstNameCell.firstNameField.text = self.user.firstName;
        }
        return self.firstNameCell;
        
    } else if (indexPath.section == self.infoUserSection && indexPath.row == LastNameRow) {
        
        self.lastNameCell = [tableView dequeueReusableCellWithIdentifier:lastNameCellIdentifier forIndexPath:indexPath];
        if (self.user) {
            self.lastNameCell.lastNameField.text = self.user.lastName;
        }
        return self.lastNameCell;
        
    } else if (indexPath.section == self.infoUserSection && indexPath.row == EmailRow) {
        
        self.emailCell = [tableView dequeueReusableCellWithIdentifier:emailCellIdentifier forIndexPath:indexPath];
        if (self.user) {
            self.emailCell.emailField.text = self.user.email;
        }
        return self.emailCell;
        
    } else if (indexPath.section == self.coursesForInstructorsSection) {
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CoursesForInstructorsCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CoursesForInstructorsCellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        Course* course = [[self.user.coursesForInstructor allObjects] objectAtIndex:indexPath.row];
        cell.textLabel.text = course.courseTitle;
        
        return cell;
        
    } else {
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CoursesForStudentsCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CoursesForStudentsCellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        Course* course = [[self.user.coursesForStudents allObjects] objectAtIndex:indexPath.row];
        cell.textLabel.text = course.courseTitle;
        
        return cell;
    }
}


#pragma mark - UITableViewDelegate
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.infoUserSection) {
        return NO;
    } else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section != self.infoUserSection) {
        
        Course* course;
        if (indexPath.section == self.coursesForInstructorsSection) {
            course = [[self.user.coursesForInstructor allObjects] objectAtIndex:indexPath.row];
            
        } else if (indexPath.section == self.coursesForStudentsSection) {
            course = [[self.user.coursesForStudents allObjects] objectAtIndex:indexPath.row];
        }
        
        CourseEditViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseEditViewController"];
        vc.course = course;
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        [self presentViewController:vc animated:YES completion:nil];
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.firstNameCell.firstNameField]) {
        [self.lastNameCell.lastNameField becomeFirstResponder];
        
    } else if ([textField isEqual:self.lastNameCell.lastNameField]) {
        [self.emailCell.emailField becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}



@end
