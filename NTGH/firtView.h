//
//  firtView.h
//  NTGH
//
//  Created by Võ Duy Hùng  on 8/16/16.
//  Copyright © 2016 Võ Duy Hùng . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface firtView : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *btn_start;
@property (weak, nonatomic) IBOutlet UIButton *btn_taiDanhSach;
@property (weak, nonatomic) IBOutlet UILabel *text;
- (IBAction)btn_start:(id)sender;
- (IBAction)btn_taiDanhSach:(id)sender;

@end
