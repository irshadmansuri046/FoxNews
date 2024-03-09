//
//  NewsCell.m
//  NewsReader
//
//  Created by GOQii-Irshad on 07/03/24.
//

#import "NewsCell.h"

@implementation NewsCell
@synthesize lblDate,lblTitle,imageThumbnail;
- (void)awakeFromNib {
    [super awakeFromNib];
    imageThumbnail.layer.cornerRadius = 8.0;
    imageThumbnail.clipsToBounds = TRUE;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
