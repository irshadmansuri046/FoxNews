//
//  NewsCell.h
//  NewsReader
//
//  Created by GOQii-Irshad on 07/03/24.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle, *lblDate;
@property (weak, nonatomic) IBOutlet UIImageView *imageThumbnail;

@end

