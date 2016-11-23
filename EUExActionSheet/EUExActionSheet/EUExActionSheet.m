//
//  EUExActionSheet.m
//  AppCan
//
//  Created by AppCan on 13-8-7.
//
//

#import "EUExActionSheet.h"
#import "EUtility.h"
#import "JSON.h"

@implementation EUExActionSheet

@synthesize actionSheet;

//- (id)initWithBrwView:(EBrowserView *)eInBrwView
//{
//    self = [super initWithBrwView:eInBrwView];
//    if (self) {
//        
//    }
//    return self;
//}

- (void)open:(NSMutableArray *)inArguments {
    if ([inArguments isKindOfClass:[NSMutableArray class]] && [inArguments count] == 5)
    {
        ACArgsUnpack(NSNumber*x,NSNumber*y,NSNumber*width,NSNumber*height,NSDictionary*dict) = inArguments;
        //y和h不处理
        NSInteger m_x = [x intValue];
        NSInteger m_y = 0;
        NSInteger m_width = [width intValue];
        if(m_width == 0){
            m_width = [EUtility screenWidth];
        }
        NSInteger m_height = 0;
       
        
            //按钮的图片
            NSString *imageStr = [[dict objectForKey:@"actionSheet_style"] objectForKey:@"btnUnSelectBgImg"];
            NSString *imagePath = [self absPath:imageStr];
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
            //按钮的数组
            NSArray *array = [[dict objectForKey:@"actionSheet_style"] objectForKey:@"actionSheetList"];
            //根据按钮的个数来计算总高度
            //加1是取消按钮，默认在最下边
            m_height = 20*2 + (array.count+1) * (image.size.height/2) + array.count * 10;
            //起始坐标
            CGRect wndRect = [UIScreen mainScreen].applicationFrame;//[EUtility brwWndFrame:meBrwView];
            m_y = wndRect.size.height - m_height;
            
            if ([dict isKindOfClass:[NSMutableDictionary class]] && dict != nil) {
                if (!self.actionSheet) {
                    self.actionSheet = [[ActionSheetView alloc] initWithFrame:CGRectMake(m_x, m_y + m_height, m_width, m_height) config:dict obj:self];
                    self.actionSheet.delegate = self;
                    //[EUtility brwView:meBrwView addSubview:self.actionSheet];
                    [[self.webViewEngine webView] addSubview:self.actionSheet];
                }
                //弹出动画
                [UIView animateWithDuration:0.25 animations:^{
                    [self.actionSheet setFrame:CGRectMake(m_x, m_y, m_width, m_height)];
                }];
            }
        }
    
}

#pragma mark -ActionSheetViewDelegate

- (void)transmitInfo:(NSString *)dataType {
    [UIView animateWithDuration:0.25 animations:^{
        [self.actionSheet setFrame:CGRectMake(actionSheet.frame.origin.x, actionSheet.frame.origin.y + actionSheet.frame.size.height, actionSheet.frame.size.width, actionSheet.frame.size.height)];
        [self performSelector:@selector(goBackActionSheet:) withObject:dataType afterDelay:0.2];
    }];
}

#pragma mark - goBack

- (void)goBackActionSheet:(NSString *)dataType {
    if (dataType.length > 0) {
        //NSString *jsString = [NSString stringWithFormat:@"uexActionSheet.onClickItem('%@');",dataType];
        //[self.meBrwView stringByEvaluatingJavaScriptFromString:jsString];
        [self.webViewEngine callbackWithFunctionKeyPath:@"uexActionSheet.onClickItem" arguments:ACArgsPack(dataType)];
    }
    if (self.actionSheet) {
        [self.actionSheet removeFromSuperview];
        self.actionSheet = nil;
    }
}

#pragma mark - close clean dealloc

- (void)clean {
    if (self.actionSheet) {
        [self.actionSheet removeFromSuperview];
        self.actionSheet = nil;
    }
}

- (void)dealloc {
    if (self.actionSheet) {
        [self.actionSheet removeFromSuperview];
        self.actionSheet = nil;
    }
    
}
@end
