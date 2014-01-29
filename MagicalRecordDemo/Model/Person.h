//
//  Person.h
//  MagicalRecordDemo
//
//  Created by Hank Wang on 2014/1/29.
//  Copyright (c) 2014年 MuBear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;

@end
