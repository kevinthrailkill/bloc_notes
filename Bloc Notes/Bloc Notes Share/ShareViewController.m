//
//  ShareViewController.m
//  Bloc Notes Share
//
//  Created by Kevin Thrailkill on 6/7/16.
//  Copyright © 2016 kevinthrailkill. All rights reserved.
//

#import "ShareViewController.h"
#import "DataController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ShareViewController ()

@end

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    
    NSExtensionItem *inputItem = self.extensionContext.inputItems.firstObject;
    NSExtensionItem *outputItem = [inputItem copy];
    outputItem.attributedContentText = [[NSAttributedString alloc] initWithString:self.contentText attributes:nil];
    
    
    [[DataController sharedInstance] saveDataForShareExtension:inputItem.attributedContentText.string andText: self.contentText];
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    NSArray *outputItems = @[outputItem];
    [self.extensionContext completeRequestReturningItems:outputItems completionHandler:nil];}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}

@end
