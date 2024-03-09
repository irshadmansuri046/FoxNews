//
//  NewsViewModel.h
//  NewsReader
//
//  Created by GOQii-Irshad on 07/03/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NewsItem.h"

@interface NewsViewModel : NSObject

@property (nonatomic, strong) NSArray<NewsItem *> *newsItems;
@property (nonatomic, strong) NSArray<NewsItem *> *filteredNewsItems;

- (void)loadNewsData;
- (void)filterNewsWithSearchText:(NSString *)searchText;
- (void)loadImageWithURLString:(NSString *)urlString completion:(void (^)(NSDictionary *))completion;
@end
