//
//  EUExActionSheet.m
//  AppCan
//
//  Created by AppCan on 13-8-7.
//
//

#import "EUExActionSheet.h"



@interface EUExActionSheet()
@property (nonatomic, strong) uexActionSheetView    *actionSheet;
@end

@implementation EUExActionSheet

@synthesize actionSheet;

- (void)open:(NSMutableArray *)inArguments {
    
    ACArgsUnpack(NSNumber *x,__unused NSNumber *y,NSNumber *width,__unused NSNumber *height,NSDictionary *dict) = inArguments;
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    //y和h不处理
    CGFloat m_x = x.floatValue;
    CGFloat m_width = width.floatValue;
    if (m_width == 0) {
        m_width = screenBounds.size.width;
    }
    
    NSDictionary *info = dictionaryArg(dict[@"actionSheet_style"]);
    uexActionSheetData *data = [self dataFromJSONInfo:info];
    
    UIImage *image = data.unselectedButtonImage;
    

    
    
    CGFloat m_height = 20 * 2 + (data.labels.count + 1) * (image.size.height / 2) + data.labels.count * 10;
    CGFloat m_y = screenBounds.size.height - m_height;

    data.frame = CGRectMake(m_x, screenBounds.size.height, m_width, m_height);

    if (!self.actionSheet) {
        self.actionSheet = [[uexActionSheetView alloc] initWithData:data euexObj:self];
        [[self.webViewEngine webView] addSubview:self.actionSheet];
    }
    //弹出动画
    [UIView animateWithDuration:0.25 animations:^{
        [self.actionSheet setFrame:CGRectMake(m_x, m_y, m_width, m_height)];
    }];
    
    
    
}

- (uexActionSheetData *)dataFromJSONInfo:(NSDictionary *)info{
    uexActionSheetData *data = [uexActionSheetData new];
    NSArray *sheets = arrayArg(info[@"actionSheetList"]);
    NSMutableArray<NSString *> *labels = [NSMutableArray array];
    for (id obj in sheets){
        if (![obj isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        NSString *label = stringArg([obj objectForKey:@"name"]);
        if (label) {
            [labels addObject:label];
        }
    }

    data.labels = labels;
    data.backgroundImage = [UIImage imageWithContentsOfFile:[self absPath:stringArg(info[@"frameBgImg"])]];
    data.borderColor = [UIColor ac_ColorWithHTMLColorString:stringArg(info[@"frameBroundColor"])];
    data.backgroundColor = [UIColor ac_ColorWithHTMLColorString:stringArg(info[@"frameBgColor"])];
    data.unselectedButtonImage = [UIImage imageWithContentsOfFile:[self absPath:stringArg(info[@"btnUnSelectBgImg"])]];
    data.selectedButtonImage = [UIImage imageWithContentsOfFile:[self absPath:stringArg(info[@"btnSelectBgImg"])]];
    data.unselectedCancelButtonImage = [UIImage imageWithContentsOfFile:[self absPath:stringArg(info[@"cancelBtnUnSelectBgImg"])]];
    data.selectedCancelButtonImage = [UIImage imageWithContentsOfFile:[self absPath:stringArg(info[@"cancelBtnSelectBgImg"])]];
    data.textFont = [UIFont systemFontOfSize:numberArg(info[@"textSize"]).integerValue];
    data.textColor = [UIColor ac_ColorWithHTMLColorString:stringArg(info[@"textNColor"])];
    data.highlightTextColor = [UIColor ac_ColorWithHTMLColorString:stringArg(info[@"textHColor"])];
    data.cancelTextColor = [UIColor ac_ColorWithHTMLColorString:stringArg(info[@"cancleTextNColor"])];
    data.highlightCancelTextColor = [UIColor ac_ColorWithHTMLColorString:stringArg(info[@"cancleTextHColor"])];
    return data;
}





#pragma mark - ActionSheetViewDelegate

- (void)uexActionSheetView:(uexActionSheetView *)actionSheetView buttonDidClickWithIndex:(NSUInteger)index isCancelButton:(BOOL)isCancelButton{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.actionSheet.frame;
        frame.origin.y += frame.size.height;
        [self.actionSheet setFrame:frame];
    } completion:^(BOOL finished) {
        if (!isCancelButton) {
            [self.webViewEngine callbackWithFunctionKeyPath:@"uexActionSheet.onClickItem" arguments:ACArgsPack(@(index))];
        }
        [self.actionSheet removeFromSuperview];
        self.actionSheet = nil;
    }];
}




- (void)clean {

    [self.actionSheet removeFromSuperview];
    self.actionSheet = nil;
    
}

- (void)dealloc {
    [self clean];
}
@end
