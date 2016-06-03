//
//  DetailViewController.h
//  Bloc Notes
//
//  Created by Kevin Thrailkill on 5/23/16.
//  Copyright © 2016 kevinthrailkill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface DetailViewController : UIViewController <UITextFieldDelegate, UIGestureRecognizerDelegate, UITextViewDelegate>

@property (strong, nonatomic) Note *note;
@property(nonatomic, strong)UIAlertAction *createAction;



@end

