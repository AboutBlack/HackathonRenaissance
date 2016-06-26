//
//  BuyViewController.m
//  HackathonClient
//
//  Created by 孙恺 on 16/6/26.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "BuyViewController.h"
#import "StepTableViewCell.h"

@interface BuyViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setTitle:@"订单信息"];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    self.navigationItem.rightBarButtonItem = btnItem;
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 3;
    }
    if(section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellID = @"SimpleCell";
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                CellID = @"SimpleCell";
                cell = [tableView dequeueReusableCellWithIdentifier:CellID];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
                    
                    [cell.textLabel setText:@"收货人"];
                    [cell.detailTextLabel setText:@"菜菜"];
                }
                break;
            case 1:
                CellID = @"SimpleCell";
                cell = [tableView dequeueReusableCellWithIdentifier:CellID];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
                    [cell.textLabel setText:@"手机号码"];
                    [cell.detailTextLabel setText:@"13800000000"];
                }
                break;
            case 2:
                CellID = @"SimpleCell";
                cell = [tableView dequeueReusableCellWithIdentifier:CellID];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
                    [cell.textLabel setText:@"收货地址"];
                    [cell.detailTextLabel setText:@"默认地址"];
                }
                break;
            default:
                CellID = @"SimpleCell";
                cell = [tableView dequeueReusableCellWithIdentifier:CellID];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
                    [cell.textLabel setText:@""];
                }
                break;
        }
        
        
        
    } else {
        CellID = @"StepCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StepTableViewCell" owner:self options:nil] lastObject];
        }
        StepTableViewCell *returnCell = (StepTableViewCell *)cell;
        [returnCell.payImageView setImage:[UIImage imageNamed:@"alipay_button"]];
        returnCell.backgroundColor = [UIColor clearColor];
        return returnCell;
    }
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
