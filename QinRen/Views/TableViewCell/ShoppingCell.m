//
//  ShoppingCell.m
//  QinRen
//
//  Created by Easaa on 15/4/7.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "ShoppingCell.h"

@implementation ShoppingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)SelectedBtn:(id)sender {
}

- (IBAction)Add:(id)sender {
    
    int i = [self.Count2Lab.text intValue];
    [self.Count2Lab setText:[NSString stringWithFormat:@"%d",++i]];
}

- (IBAction)mInue:(id)sender {
    
    _Count2Lab.text=0;
    
    int i = [self.Count2Lab.text intValue];
    if (i != 0) {
        [self.Count2Lab setText:[NSString stringWithFormat:@"%d",--i]];
    }
}
@end
