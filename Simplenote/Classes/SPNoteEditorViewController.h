#import <UIKit/UIKit.h>
#import "SPActionSheet.h"
#import "SPActivityView.h"
#import "SPTagView.h"
#import "SPAddCollaboratorsViewController.h"
#import "SPHorizontalPickerView.h"
#import <Simperium/Simperium.h>
@class Note;
@class SPTextView;
@class SPEditorTextView;
@class SPOutsideTouchView;

@interface SPNoteEditorViewController : UIViewController  <SPActionSheetDelegate, SPActivityViewDelegate, UIActionSheetDelegate, SPTagViewDelegate, SPCollaboratorDelegate, SPHorizontalPickerViewDelegate, SPBucketDelegate> {
    
    // Other Objects
    NSTimer *saveTimer;
    NSTimer *guarenteedSaveTimer;
    
    // BOOLS
    BOOL bBlankNote;
    BOOL bModified;
    BOOL bDisableShrinkingNavigationBar;
    BOOL bShouldDelete;
    BOOL bViewingVersions;
    BOOL beditingTags;
    BOOL bActionSheetVisible;
    BOOL bVoiceoverEnabled;
    
    CGAffineTransform navigationBarTransform;
    CGFloat scrollPosition;
    
    SPOutsideTouchView *navigationButtonContainer;
    
    UIBarButtonItem *nextSearchButton;
    UIBarButtonItem *prevSearchButton;
    UIBarButtonItem *doneSearchButton;
    
    // sheets
    SPActivityView *noteActivityView;
    SPActionSheet *noteActionSheet;
    SPActionSheet *versionActionSheet;
    
    SPHorizontalPickerView *versionPickerView;
    
    BOOL bSearching;
    NSInteger highlightedSearchResultIndex;
    
    UILabel *searchDetailLabel;
    
    NSInteger currentVersion;
    NSMutableDictionary *noteVersionData;
    
}

// Navigation Back Button
@property (nonatomic, strong) UIButton *backButton;

// Navigation Buttons
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIButton *checklistButton;
@property (nonatomic, strong) UIButton *keyboardButton;
@property (nonatomic, strong) UIButton *createNoteButton;

@property (nonatomic, strong) Note *currentNote;
@property (nonatomic, strong) SPEditorTextView *noteEditorTextView;
@property (nonatomic, strong) SPTagView *tagView;
@property (nonatomic, strong) NSString *searchString;

@property (nonatomic, getter=isEditingNote) BOOL editingNote;
@property (nonatomic, getter=isPreviewing) BOOL previewing;
@property (nonatomic, getter=isKeyboardVisible) BOOL keyboardVisible;

- (void)prepareToPopView;
- (void)updateNote:(Note *)note;
- (void)setSearchString:(NSString *)string;
- (void)clearNote;

- (void)willReceiveNewContent;
- (void)didReceiveNewContent;
- (void)didReceiveVersion:(NSString *)version data:(NSDictionary *)data;
- (void)didDeleteCurrentNote;

- (void)save;

@end
