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

@property (weak, nonatomic) IBOutlet UILabel *createdLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) UITextField *alertField;



- (IBAction)shareNote:(id)sender;

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
        
        BOOL isNew = [[_note valueForKey:@"isNew"] boolValue];
        
        
        if(isNew){
            //show setup stuff for title and note
            
            
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
//                                                             style:UIAlertActionStyleDefault
//                                                           handler:^(UIAlertAction *action)
//                                     {
//                                        [self.navigationController popToRootViewControllerAnimated:YES];
//                                     }];
            
            
            
            self.createAction = [UIAlertAction actionWithTitle:@"Create Note"
                                                             style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action)
                                 {
                                     self.titleField.text = self.alertField.text;
                                     [_note setValue:self.titleField.text forKey:@"title"];
                                 }];
            self.createAction.enabled = NO;

            
            
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"New Note"
                                                                    message:nil
                                                             preferredStyle:UIAlertControllerStyleAlert];
            
            [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.delegate = self;
                textField.placeholder = @"Please Enter A Title";
                self.alertField = textField;
                [_note setValue:[NSNumber numberWithBool:NO] forKey:@"isNew"];
            }];
           // [controller addAction:cancel];
            [controller addAction:self.createAction];
            [self presentViewController:controller animated:YES completion:nil];
            
        }
        
        
        self.titleField.text = [_note valueForKey:@"title"];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm:ss a"];
        
        
        NSString *stringFromDate = [dateFormatter stringFromDate:[_note valueForKey:@"lastModified"]];
        self.lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", stringFromDate];
        
        NSString *stringFromDateCreate = [dateFormatter stringFromDate:[_note valueForKey:@"dateCreated"]];
        self.createdLabel.text = [NSString stringWithFormat:@"Created On: %@", stringFromDateCreate];
        
        
        self.noteTextView.text = [[self.note valueForKey:@"body"] description];
        self.noteTextView.delegate = self;
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTextRecognizerTabbed:)];
        recognizer.delegate = self;
        recognizer.numberOfTapsRequired = 1;
        [self.noteTextView addGestureRecognizer:recognizer];
        
        
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self.createAction setEnabled:(finalString.length >= 1)];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void) editTextRecognizerTabbed:(UITapGestureRecognizer *) aRecognizer;
{
    self.noteTextView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.noteTextView.editable = YES;
    [self.noteTextView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView;
{
    self.noteTextView.editable = NO;
    self.noteTextView.dataDetectorTypes = UIDataDetectorTypeAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.noteTextView becomeFirstResponder];
    
    
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_note setValue:self.noteTextView.text forKey:@"body"];
    [_note setValue:[NSDate date] forKey:@"lastModified"];
    [_note setValue:self.titleField.text forKey:@"title"];
    [_note setValue:[NSNumber numberWithBool:NO] forKey:@"isNew"];


    
    [[DataController sharedInstance] saveContext];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareNote:(id)sender {
    
    NSMutableArray *itemsToShare = [NSMutableArray array];
    
    
    
    if (self.note.title.length > 0) {
        [itemsToShare addObject:self.note.title];
    }
    
    [itemsToShare addObject:self.createdLabel.text];
    [itemsToShare addObject:self.lastUpdatedLabel.text];
    
    if (self.noteTextView.text.length > 0) {
        [itemsToShare addObject:self.noteTextView.text];
    }
    
    if (itemsToShare.count > 0) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}
@end
