//
//  Note+CoreDataProperties.h
//  Bloc Notes
//
//  Created by Kevin Thrailkill on 5/23/16.
//  Copyright © 2016 kevinthrailkill. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Note.h"

NS_ASSUME_NONNULL_BEGIN

@interface Note (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *timeStamp;
@property (nullable, nonatomic, retain) NSString *body;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSDate *last_modified;

@end

NS_ASSUME_NONNULL_END
