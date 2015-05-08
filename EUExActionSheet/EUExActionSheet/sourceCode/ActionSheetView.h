//
//  ActionSheetView.h
//  AppCan
//
//  Created by AppCan on 13-8-7.
//
//

#import <UIKit/UIKit.h>

@class EUExActionSheet;
@protocol ActionSheetViewDelegate;

@interface ActionSheetView : UIView
{
    NSMutableDictionary     *_ConfigDict;
    NSMutableArray          *_BtnConfigArray;
}

@property (nonatomic, assign) id<ActionSheetViewDelegate>       delegate;
@property (nonatomic, retain) NSMutableDictionary               *configDict;
@property (nonatomic, retain) NSMutableArray                    *btnConfigArray;
@property (nonatomic ,retain) EUExActionSheet                   *m_actionSheet;

- (id)initWithFrame:(CGRect)frame config:(NSMutableDictionary *)aConfig obj:(EUExActionSheet *)aObject;

@end

@protocol ActionSheetViewDelegate <NSObject>
- (void)transmitInfo:(NSString *)dataType;
@end