//
//  DataController.h
//  Bloc Notes
//
//  Created by Kevin Thrailkill on 5/23/16.
//  Copyright © 2016 kevinthrailkill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataController : NSObject


+(instancetype) sharedInstance;


//flurry
@property (nonatomic, strong, readonly) NSString *flurryAccessToken;


//Core data stuff
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;




@end
