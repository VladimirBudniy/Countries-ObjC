//
//  VBCountriesViewController.m
//  Counries-ObjC
//
//  Created by Vladimir Budniy on 1/23/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBCountriesViewController.h"
#import "VBDetailVeiwController.h"
#import "VBCountriesView.h"
#import "VBCountryCell.h"
#import "VBNetworkCountries.h"

VBViewControllerRootViewProperty(VBCountriesViewController, VBCountriesView)

@interface VBCountriesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)   NSMutableArray  *countries;
@property (nonatomic, assign)   NSUInteger       page;
@property (nonatomic, assign)   NSUInteger       pagesCount;

- (UITableView *)tableView;
- (void)load;
- (void)reloadRootViewData;
- (VBNetworkHandler)handler;

- (id)classForIdentifire:(NSString *)identifire;
- (void)addRefreshControl;
- (void)refreshView;

@end

@implementation VBCountriesViewController 

#pragma mark -
#pragma mark Initializations and Deallocatins

- (instancetype)init {
    self = [super init];
    if (self) {
        self.countries = [NSMutableArray new];
        self.page = 1;
        self.pagesCount = 11;
    }
    
    return self;
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRefreshControl];
    [self load];
}

#pragma mark -
#pragma mark Private

- (UITableView *)tableView {
    return self.rootView.tableView;
}

- (void)addRefreshControl {
    UIRefreshControl *control = [UIRefreshControl new];
    control.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refersh"];
    [control addTarget:self action:@selector(refreshView) forControlEvents:UIControlEventValueChanged];
    [self tableView].refreshControl = control;
}

- (void)refreshView {
    [NSManagedObjectContext removeAllInBackground];
    [self.countries removeAllObjects];
    [[self tableView] reloadData];
    self.page = 1;
    [self load];
}

- (VBNetworkHandler)handler {
    return ^(id object) {
        [self.countries addObjectsFromArray:object];
        [self reloadRootViewData];
    };
}

- (void)load {
    VBNetworkCountries *model = [VBNetworkCountries modelWithHandler:[self handler]];
    [model urlForLoadingWith:[NSNumber numberWithInteger:self.page]];
}

- (void)reloadRootViewData {
    UITableView *tableView = [self tableView];
    [tableView reloadData];
    [tableView.refreshControl endRefreshing];
}

- (id)classForIdentifire:(NSString *)identifire {
    id class = NSClassFromString(identifire);
    return [class class];
}

#pragma mark -
#pragma mark TableView DataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.countries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithBundleClass:[self classForIdentifire:@"VBCountryCell"]];
    [cell fillWithModel:self.countries[indexPath.row]];

    return cell;
}

#pragma mark
#pragma mark TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VBCountry *country = self.countries[indexPath.row];
    NSString *name = country.name;
    VBDetailVeiwController *controller = [[VBDetailVeiwController alloc] initWithCountryName:name];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = tableView.numberOfSections - 1;
    NSUInteger lastRow = [tableView numberOfRowsInSection:section] - 1;
    if (indexPath.row == lastRow && self.page < self.pagesCount) {
        self.page += 1;
        [self load];
    }
}

@end
