//
//  ViewController.m
//  NewsReader
//
//  Created by GOQii-Irshad on 07/03/24.
//

#import "ViewController.h"
#import "NewsCell.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NEWS";
    self.catchImages = [[NSMutableDictionary alloc] init];
    self.viewModel = [[NewsViewModel alloc] init];
    
    // Initialize and configure UITableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    // Initialize and configure UISearchBar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search for news";
    self.tableView.tableHeaderView = self.searchBar;
    
    // Load news data
    [self.viewModel loadNewsData];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.filteredNewsItems.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsItem *newsItem = self.viewModel.filteredNewsItems[indexPath.row];
    NSString *title = newsItem.title;

    CGFloat maxWidth = tableView.frame.size.width - 120.0; // 120 is left and right padding and image width
    
    UIFont *font = [UIFont systemFontOfSize:17.0];
    CGRect boundingRect = [title boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName: font}
                                              context:nil];
    
    return ceil(CGRectGetHeight(boundingRect)) + 40.0; // Add extra padding as needed
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifire = @"NewsCell";
    
    NewsCell *cell = (NewsCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil] objectAtIndex:1];
    }
    NewsItem *newsItem = self.viewModel.filteredNewsItems[indexPath.row];
    cell.lblTitle.text = newsItem.title;
    cell.lblDate.text = newsItem.publishedDate;
    
    UIImage *catchedImg = [_catchImages valueForKey:newsItem.imageURL];
    if (catchedImg == nil){
        // Load news image asynchronously
        [self.viewModel loadImageWithURLString:newsItem.imageURL completion:^(NSDictionary *result) {
            if (result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Check if the cell is still visible
                    if ([tableView.indexPathsForVisibleRows containsObject:indexPath]) {
                        NewsCell *updateCell = (NewsCell *)[tableView cellForRowAtIndexPath:indexPath];
                        if (updateCell) {
                            updateCell.imageThumbnail.image = [result valueForKey:@"img"];
                            
                            [updateCell setNeedsLayout];
                            // catch image
                            [self->_catchImages setValue:[result valueForKey:@"img"] forKey:[result valueForKey:@"url"]];
                        }
                    }
                });
            }
        }];
    }else{
        cell.imageThumbnail.image = catchedImg;
    }
    return cell;
}

#pragma mark - UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.viewModel filterNewsWithSearchText:searchText];
    [self.tableView reloadData];
}

@end
