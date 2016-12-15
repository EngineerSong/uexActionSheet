//
//  ActionSheetView.m
//  AppCan
//
//  Created by AppCan on 13-8-7.
//
//

#import "uexActionSheetView.h"
#import <QuartzCore/QuartzCore.h>
#import "EUExActionSheet.h"

@implementation uexActionSheetData

@end


@interface  uexActionSheetView()
@property (nonatomic,weak) EUExActionSheet *euexObj;
@property (nonatomic,strong)uexActionSheetData *data;
@end


@implementation uexActionSheetView


#pragma mark - button events

- (void)buttonClicked:(UIButton *)sender {
    NSUInteger tag = sender.tag;
    BOOL isCancelButton = (tag == self.data.labels.count);
    [self.euexObj uexActionSheetView:self buttonDidClickWithIndex:tag isCancelButton:isCancelButton];

}



- (instancetype)initWithData:(uexActionSheetData *)data euexObj:(EUExActionSheet *)euexObj{
    if (!data || !euexObj){
        return nil;
    }
    self = [super initWithFrame:data.frame];{
        _data = data;
        _euexObj = euexObj;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UIImageView *background = [[UIImageView alloc]initWithFrame:self.bounds];
    background.image = self.data.backgroundImage;
    if (self.data.borderColor) {
        background.layer.borderWidth = 1;
        background.layer.borderColor = self.data.borderColor.CGColor;
    }
    [self addSubview:background];
    self.backgroundColor = self.data.backgroundColor;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 3;
    for (NSInteger i = 0; i < self.data.labels.count; i++){
        UIButton *button = [self makeButtonWithIndex:i];
        [button setTitle:self.data.labels[i] forState:UIControlStateNormal];
        [button setTitleColor:self.data.highlightTextColor forState:UIControlStateHighlighted];
        [button setTitleColor:self.data.textColor forState:UIControlStateNormal];
        [button setBackgroundImage:self.data.unselectedButtonImage forState:UIControlStateNormal];
        [button setBackgroundImage:self.data.selectedButtonImage forState:UIControlStateHighlighted];
        [self addSubview:button];
    }
    UIButton *cancelButton = [self makeButtonWithIndex:self.data.labels.count];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:self.data.cancelTextColor forState:UIControlStateNormal];
    [cancelButton setTitleColor:self.data.highlightCancelTextColor forState:UIControlStateHighlighted];
    [cancelButton setBackgroundImage:self.data.selectedCancelButtonImage forState:UIControlStateHighlighted];
    [cancelButton setBackgroundImage:self.data.unselectedCancelButtonImage forState:UIControlStateNormal];
    [self addSubview:cancelButton];
    
}

- (UIButton *)makeButtonWithIndex:(NSUInteger)index{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat height = self.data.unselectedButtonImage.size.height / 2;
    button.frame = CGRectMake(20, 20 + index * (height + 10), self.frame.size.width - 40, height);
    button.tag = index;
    [button.titleLabel setFont:self.data.textFont];
    button.showsTouchWhenHighlighted = YES;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}





@end
