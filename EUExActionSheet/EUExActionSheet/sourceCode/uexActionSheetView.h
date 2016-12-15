//
//  ActionSheetView.h
//  AppCan
//
//  Created by AppCan on 13-8-7.
//
//

#import <UIKit/UIKit.h>

@class EUExActionSheet;

@interface uexActionSheetData: NSObject
@property (nonatomic,assign)CGRect frame;
@property (nonatomic,strong)UIColor *backgroundColor;
@property (nonatomic,strong)UIColor *borderColor;
@property (nonatomic,strong)UIImage *backgroundImage;
@property (nonatomic,strong)UIImage *unselectedButtonImage;
@property (nonatomic,strong)UIImage *selectedButtonImage;
@property (nonatomic,strong)UIImage *unselectedCancelButtonImage;
@property (nonatomic,strong)UIImage *selectedCancelButtonImage;
@property (nonatomic,strong)UIFont *textFont;
@property (nonatomic,strong)UIColor *textColor;
@property (nonatomic,strong)UIColor *highlightTextColor;
@property (nonatomic,strong)UIColor *cancelTextColor;
@property (nonatomic,strong)UIColor *highlightCancelTextColor;
@property (nonatomic,strong)NSArray<NSString *> *labels;



@end;


@interface uexActionSheetView : UIView
- (instancetype)initWithData:(uexActionSheetData *)data euexObj:(EUExActionSheet *)euexObj;

@end

@protocol uexActionSheetViewDelegate <NSObject>
- (void)uexActionSheetView:(uexActionSheetView *)actionSheetView buttonDidClickWithIndex:(NSUInteger)index isCancelButton:(BOOL)isCancelButton;
@end
