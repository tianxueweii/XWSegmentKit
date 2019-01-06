//
//  XWSegmentViewController.m
//  XWSegmentKit
//
//  Created by tianxueweii on 01/06/2019.
//  Copyright (c) 2019 tianxueweii. All rights reserved.
//

#import "XWSegmentViewController.h"
#import "XWSegmentStyle1Controller.h"
#import "XWSegmentStyle2Controller.h"
#import "XWSegmentStyle3Controller.h"

@interface XWSegmentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *funcList;

@end

@implementation XWSegmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.funcList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.funcList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            UIViewController *vc = [[XWSegmentStyle1Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        
        case 1: {
            UIViewController *vc = [[XWSegmentStyle2Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        
        case 2: {
            UIViewController *vc = [[XWSegmentStyle3Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}


#pragma mark - Get

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSArray *)funcList {
    return @[@"渐变带横线指针导航",
             @"锚点在底部导航",
             @"自定义指针导航"];
}

@end
