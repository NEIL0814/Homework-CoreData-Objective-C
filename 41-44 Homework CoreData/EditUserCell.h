//
//  EditUserCell.h
//  41-44 Homework CoreData
//
//  Created by Vladimir on 04.11.16.
//  Copyright © 2016 Vladimir Gordienko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditUserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@end
