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
#import "VBContext.h"
#import "VBNetwork.h"

@interface VBCountriesViewController ()
@property (nonatomic, readonly) UITableView     *tableView;
@property (nonatomic, readonly) VBCountriesView *rootView;
@property (nonatomic, strong)   NSMutableArray  *countries;

@property (nonatomic, assign)   NSUInteger page;

- (void)load;
- (void)reloadRootViewData;
- (VBNetworkHandler)handler;

- (void)addRefreshControl;
- (void)refreshView;
@end

@implementation VBCountriesViewController

#pragma mark -
#pragma mark Accessors

VBRootViewAndReturnIfNilMacro(VBCountriesView);

- (void)setCountries:(NSMutableArray *)countries {
    if (_countries != countries) {
        _countries = countries;
        
        [self reloadRootViewData];
    }
}

-(UITableView *)tableView {
    return self.rootView.tableView;
}

#pragma mark -
#pragma mark Initializations and Deallocatins

- (instancetype)init {
    self = [VBCountriesViewController controllerFromNib];
    if (self) {
        self.page = 1;
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

- (void)addRefreshControl {
    UIRefreshControl *control = [UIRefreshControl new];
    control.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refersh"];
    [control addTarget:self action:@selector(refreshView) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = control;
}

- (void)refreshView {
    self.page = 1;
    [[VBContext sharedObject] removeAll];
    [self load];
}

- (VBNetworkHandler)handler {
    return ^(id object) {
        self.countries = object;
    };
}

- (void)load {
    VBNetwork *networkModel = [[VBNetwork alloc] initWithHandler:[self handler]];
    [networkModel prepareToLoadWith:[NSNumber numberWithInteger:self.page]];
}

- (void)reloadRootViewData {
    VBCountriesView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.tableView.refreshControl endRefreshing];
}

- (id)tableView:(UITableView *)tableView cellAtIndexPath:(NSIndexPath *)indexPath class:(Class)theClass {
    id currentCell = [tableView dequeueReusableCellWithBundleClass:[theClass class]];
    [currentCell fillWithCounty:self.countries[indexPath.row]];
    UITableViewCell *cell = currentCell;
    [tableView setRowHeight:cell.contentView.frame.size.height];
    
    return cell;
}

#pragma mark -
#pragma mark TableView DataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.countries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView cellAtIndexPath:indexPath class:[VBCountryCell class]];
}

#pragma mark
#pragma mark TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VBDetailVeiwController *controller = [VBDetailVeiwController new];
    VBCountry *country = self.countries[indexPath.row];
    controller.countryName = country.name;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = tableView.numberOfSections - 1;
    NSUInteger lastRow = [tableView numberOfRowsInSection:section] - 1;
    if (indexPath.row == lastRow) {
        self.page += 1;
        [self load];
    }
}

@end
