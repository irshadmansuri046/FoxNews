//
//  NewsItem.m
//  NewsReader
//
//  Created by GOQii-Irshad on 07/03/24.
//

#import "NewsItem.h"

@implementation NewsItem

- (instancetype)initWithTitle:(NSString *)title publishedDate:(NSString *)publishedDate imageURL:(NSString *)imageURL articleURL:(NSString *)articleURL {
    self = [super init];
    if (self) {
        _title = title;
        _publishedDate = publishedDate;
        _imageURL = imageURL;
        _articleURL = articleURL;
    }
    return self;
}

@end
