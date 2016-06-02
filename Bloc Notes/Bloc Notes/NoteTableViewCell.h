//
//  NoteTableViewCell.h
//  Bloc Notes
//
//  Created by Kevin Thrailkill on 6/1/16.
//  Copyright © 2016 kevinthrailkill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *updatedRecentlyLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
