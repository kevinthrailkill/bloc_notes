//
//  Note+CoreDataProperties.m
//  Bloc Notes
//
//  Created by Kevin Thrailkill on 6/1/16.
//  Copyright © 2016 kevinthrailkill. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Note+CoreDataProperties.h"

@implementation Note (CoreDataProperties)

@dynamic body;
@dynamic lastModified;
@dynamic dateCreated;
@dynamic title;
@dynamic isNew;

@end
