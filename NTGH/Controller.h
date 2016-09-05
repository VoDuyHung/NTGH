//
//  Controller.h
//  NTGH
//
//  Created by Võ Duy Hùng  on 7/5/16.
//  Copyright © 2016 Võ Duy Hùng . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Controller : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *img_bg;
@property (strong, nonatomic) NSArray * filteredTableData;
@property (nonatomic, assign) bool isFiltered;
@end
