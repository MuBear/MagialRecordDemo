//
//  ViewController.m
//  MagicalRecordDemo
//
//  Created by Hank Wang on 2014/1/29.
//  Copyright (c) 2014年 MuBear. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)addPersonButton:(UIButton *)sender {

    if (![self.nameTextField.text length] || ![self.ageTextField.text length]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"name and age can't be empty." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        Person *newPerson = [Person MR_createEntity];
        newPerson.name = self.nameTextField.text;
        newPerson.age = [NSNumber numberWithInteger: [self.ageTextField.text integerValue]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
        [self.nameTextField resignFirstResponder];
        [self.ageTextField resignFirstResponder];
        NSLog(@"new Person added");
        [self updateCount];
    }
}
- (IBAction)deleteAge23Button:(UIButton *)sender {
    NSArray *persons = [Person MR_findByAttribute:@"age" withValue:[NSNumber numberWithInt:23]];
    if ([persons count] > 0) {
        for (Person *person in persons) {
            [person MR_deleteEntity];
        }
        [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
        [self updateCount];
    }
}

- (IBAction)allRecordButton:(UIButton *)sender {
    NSArray *persons = [Person MR_findAll];
    if ([persons count] > 0) {
        for (Person *aPerson in persons) {
            NSLog(@"%@ - %@", aPerson.name, aPerson.age);
        }
    } else {
        NSLog(@"entry empty");
    }

}
- (IBAction)firstRecordButton:(id)sender {
    Person *aPerson = [Person MR_findFirst];
    
    if (aPerson) {
        NSLog(@"%@ - %@", aPerson.name, aPerson.age);
    } else {
        NSLog(@"entry empty");
    }
}
- (IBAction)clearAllButton:(UIButton *)sender {
    [Person MR_truncateAll];
}

- (void)resetCoreData {
    NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:[MagicalRecord defaultStoreName]];

    NSLog(@"%@", storeURL);

    [MagicalRecord cleanUp];

    NSError *error;

    if([[NSFileManager defaultManager] removeItemAtURL:storeURL error: &error]){
        NSLog(@"remove successful");
        [MagicalRecord setupAutoMigratingCoreDataStack];
        [self updateCount];
    } else{
        NSLog(@"%@", error);
        NSLog(@"remove failed");
    }
}

- (void)updateCount {
    self.countLabel.text = [NSString stringWithFormat: @"Count: %d", [Person MR_countOfEntities]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateCount];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
