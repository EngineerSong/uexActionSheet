//
//  ActionSheetView.m
//  AppCan
//
//  Created by AppCan on 13-8-7.
//
//

#import "ActionSheetView.h"
#import <QuartzCore/QuartzCore.h>
#import "EUExActionSheet.h"
#import "pub_actionS.h"

#define BUTTON_TAG      1231

@implementation ActionSheetView
@synthesize delegate;
@synthesize configDict = _ConfigDict;
@synthesize btnConfigArray = _BtnConfigArray;
@synthesize m_actionSheet;

#pragma mark - button events

- (void)buttonClick:(UIButton *)sender {
    NSInteger tag = sender.tag - BUTTON_TAG;
    NSString *dataType = [NSString stringWithFormat:@"%ld",(long)tag];
    if (tag == _BtnConfigArray.count) {
        if (delegate && [delegate respondsToSelector:@selector(transmitInfo:)]) {
            [delegate transmitInfo:[NSString stringWithFormat:@"-1"]];
        }
    }else {
        if (delegate && [delegate respondsToSelector:@selector(transmitInfo:)]) {
            [delegate transmitInfo:dataType];
        }
    }
}

#pragma mark - initWithFrame

- (void)initButtonView:(CGRect)bFrame {
    NSInteger screenWidth = bFrame.size.width;
    NSInteger btnCount = 0;
    if ([_BtnConfigArray isKindOfClass:[NSMutableArray class]] && _BtnConfigArray.count>0) {
        btnCount = [_BtnConfigArray count] + 1;
    }else {
        btnCount = 1;
    }
    //未点击
    NSString *btnUnSelectBgImg = [[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"btnUnSelectBgImg"];
    NSString *btnUnSelectPath = [m_actionSheet absPath:btnUnSelectBgImg];
    UIImage *btnUnSelectImage = [UIImage imageWithContentsOfFile:btnUnSelectPath];
    //点击
    NSString *btnSelectBgImg = [[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"btnSelectBgImg"];
    NSString *btnSelectPath = [m_actionSheet absPath:btnSelectBgImg];
    //未点击 取消
    NSString *cancelBtnUnSelectBgImg = [[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"cancelBtnUnSelectBgImg"];
    NSString *cancelBtnUnSelectPath = [m_actionSheet absPath:cancelBtnUnSelectBgImg];
    //点击 取消
    NSString *cancelBtnSelectBgImg = [[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"cancelBtnSelectBgImg"];
    NSString *cancelBtnSelectPath = [m_actionSheet absPath:cancelBtnSelectBgImg];
    //字体大小
    CGFloat textSize = [[[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"textSize"] floatValue];
    //字体颜色
    NSString *textColor = [[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"textNColor"];
    NSString *textHColor=[[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"textHColor"];
    NSString *cancelTextNColor = [[_ConfigDict objectForKey:@"actionSheet_style"]objectForKey:@"cancelTextNColor"];
    NSString *cancelTextHColor = [[_ConfigDict objectForKey:@"actionSheet_style"]objectForKey:@"cancelTextHColor"];
    
    for (int i = 0; i<btnCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(20, 20+i*(btnUnSelectImage.size.height/2)+i*10, screenWidth-40, btnUnSelectImage.size.height/2)];
        [button setTag:BUTTON_TAG + i];
        [button.titleLabel setFont:[UIFont systemFontOfSize:textSize]];
       // [button.titleLabel setTextColor:[pub_actionS stringToColor:textColor]];
       //最后一个按钮是取消
        if (i == btnCount-1) {
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithContentsOfFile:cancelBtnUnSelectPath] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithContentsOfFile:cancelBtnSelectPath] forState:UIControlStateHighlighted];
            [button setTitleColor:[pub_actionS stringToColor:cancelTextHColor] forState:UIControlStateHighlighted];
            button.showsTouchWhenHighlighted=YES;
            [button setTitleColor:[pub_actionS stringToColor:cancelTextNColor] forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[pub_actionS stringToColor:textHColor] forState:UIControlStateHighlighted];
            button.showsTouchWhenHighlighted=YES;
            [button setTitleColor:[pub_actionS stringToColor:textColor] forState:UIControlStateNormal];
            [button setTitle:[[_BtnConfigArray objectAtIndex:i] objectForKey:@"name"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithContentsOfFile:btnUnSelectPath] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithContentsOfFile:btnSelectPath] forState:UIControlStateHighlighted];
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
}

#pragma mark - initWithFrame

- (id)initWithFrame:(CGRect)frame config:(NSMutableDictionary *)aConfig obj:(EUExActionSheet *)aObject {
    self = [super initWithFrame:frame];
    if (self) {
        self.configDict = [NSMutableDictionary dictionaryWithDictionary:aConfig];
        self.m_actionSheet = aObject;
        if ([_ConfigDict isKindOfClass:[NSMutableDictionary class]] && _ConfigDict != nil) {
            NSString *frameBgImage = [[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"frameBgImg"];
            NSString *frameBroundColor = [[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"frameBroundColor"];
            
            if ([frameBgImage isKindOfClass:[NSString class]] && frameBgImage.length > 0) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
                NSString *imagePath = [m_actionSheet absPath:frameBgImage];
                [imageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
                if ([frameBroundColor isKindOfClass:[NSString class]] && frameBroundColor.length > 0) {
                    [imageView.layer setBorderWidth:1.0];
                    [imageView.layer  setBorderColor:[pub_actionS stringToColor:frameBroundColor].CGColor];
                }
                [self addSubview:imageView];
                [imageView release];
            } else {
                NSString *frameBgColor = [[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"frameBgColor"];
                [self setBackgroundColor:[pub_actionS stringToColor:frameBgColor]];
                NSString *framebroadColor = [[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"frameBroundColor"];
                [self.layer setBorderWidth:1.0];
                [self.layer setBorderColor:[pub_actionS stringToColor:framebroadColor].CGColor];
            }
            [self.layer setCornerRadius:3.0];
            [self setClipsToBounds:YES];
            NSArray *array = [[_ConfigDict objectForKey:@"actionSheet_style"] objectForKey:@"actionSheetList"];
            if ([array isKindOfClass:[NSArray class]] && array.count > 0) {
                self.btnConfigArray = [NSMutableArray arrayWithArray:array];
            }
        } else {
            //
        }
        //初始化button
        [self initButtonView:frame];
    }
    return self;
}


#pragma mark - dealloc

- (void)dealloc
{
    if (self.configDict) {
        self.configDict = nil;
    }
    if (self.btnConfigArray) {
        self.btnConfigArray = nil;
    }
    if (self.m_actionSheet) {
        self.m_actionSheet = nil;
    }
    
    [super dealloc];
}

@end
