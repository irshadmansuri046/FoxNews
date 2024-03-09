//
//  NewsItem.h
//  NewsReader
//
//  Created by GOQii-Irshad on 07/03/24.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *publishedDate;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *articleURL;

- (instancetype)initWithTitle:(NSString *)title publishedDate:(NSString *)publishedDate imageURL:(NSString *)imageURL articleURL:(NSString *)articleURL;

@end
