//
//  EUExActionSheet.h
//  AppCan
//
//  Created by AppCan on 13-8-7.
//
//

#import <UIKit/UIKit.h>
#import "ActionSheetView.h"

@interface EUExActionSheet : EUExBase <ActionSheetViewDelegate>
{
    ActionSheetView    *actionSheet;
}
@property (nonatomic, retain) ActionSheetView    *actionSheet;
@end
