//
//  ViewController.h
//  NewsReader
//
//  Created by GOQii-Irshad on 07/03/24.
//

#import <UIKit/UIKit.h>
#import "NewsViewModel.h"
@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NewsViewModel *viewModel;
@property (nonatomic, strong) NSMutableDictionary *catchImages;

@end

