//
//  NewsViewModel.m
//  NewsReader
//
//  Created by GOQii-Irshad on 07/03/24.
//

#import "NewsViewModel.h"

@implementation NewsViewModel

- (void)loadNewsData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dicArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (!error) {
        NSArray *subArray = dicArray[@"articles"];
        if (subArray.count != 0){
            NSMutableArray *newsItems = [NSMutableArray array];
            
            NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
            [inputDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
           

            NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
            [outputDateFormatter setDateFormat:@"MMMM dd, yyyy h:mm a"];
            
            for (NSDictionary *dict in subArray) {
                NSDate *date = [inputDateFormatter dateFromString:dict[@"publishedAt"]];
                NSString *formattedDateString = [outputDateFormatter stringFromDate:date];
                NewsItem *newsItem = [[NewsItem alloc] initWithTitle:dict[@"title"] publishedDate:formattedDateString imageURL:dict[@"urlToImage"] articleURL:dict[@"url"]];
                
                [newsItems addObject:newsItem];
            }
            self.newsItems = [newsItems sortedArrayUsingComparator:^NSComparisonResult(NewsItem *obj1, NewsItem *obj2) {
                return [obj2.publishedDate compare:obj1.publishedDate];
            }];
            self.filteredNewsItems = [self.newsItems copy];
        }
    } else {
        NSLog(@"Error loading news data: %@", error.localizedDescription);
    }
}

- (void)filterNewsWithSearchText:(NSString *)searchText {
    if (searchText.length == 0) {
        self.filteredNewsItems = [self.newsItems copy];
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", searchText];
        self.filteredNewsItems = [self.newsItems filteredArrayUsingPredicate:predicate];
    }
}
- (void)loadImageWithURLString:(NSString *)urlString completion:(void (^)(NSDictionary *))completion {
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        //NSLog(@"Invalid URL: %@", urlString);
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"noimg"],@"img",@"NO_IMG",@"url", nil];
        completion(data);
        return;
    }
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error loading image: %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:image,@"img",urlString,@"url", nil];
        completion(result);
    }];
    [task resume];
}
@end
