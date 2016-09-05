//
//  TableViewCell.h
//  NTGH
//
//  Created by Võ Duy Hùng  on 7/5/16.
//  Copyright © 2016 Võ Duy Hùng . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageCell;
@property (weak, nonatomic) IBOutlet UILabel *LableCell;
@property (weak, nonatomic) IBOutlet UIButton *iconCell;

@end
