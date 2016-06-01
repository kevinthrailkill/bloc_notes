//
//  DetailViewController.m
//  Bloc Notes
//
//  Created by Kevin Thrailkill on 5/23/16.
//  Copyright © 2016 kevinthrailkill. All rights reserved.
//

#import "DetailViewController.h"
#import "DataController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Note*)newNote {
    if (_note != newNote) {
        _note = newNote;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.note) {
        self.detailDescriptionLabel.text = [[self.note valueForKey:@"timeStamp"] description];
        self.noteTextView.text = [[self.note valueForKey:@"body"] description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_note setValue:self.noteTextView.text forKey:@"body"];
    [_note setValue:[NSDate date] forKey:@"last_modified"];
    
    [[DataController sharedInstance] saveContext];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
