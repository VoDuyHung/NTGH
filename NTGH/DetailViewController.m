//
//  DetailViewController.m
//  NTGH
//
//  Created by Võ Duy Hùng  on 7/5/16.
//  Copyright © 2016 Võ Duy Hùng . All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#import "TableViewCell.h"
#import "Controller.h"
#define IS_IPHONE6PLUS (([[UIScreen mainScreen] bounds].size.width)==414.0f && ([[UIScreen mainScreen]  bounds].size.height)==736.0f)
#define IS_IPHONE6 (([[UIScreen mainScreen]bounds].size.width)==375.0f && ([[UIScreen mainScreen]bounds].size.height)==667.0f)
#define IS_IPHONE5S5 (([[UIScreen mainScreen]bounds].size.width)==320.0f && ([[UIScreen mainScreen]bounds].size.height)==568.0f)
#define IS_IPHONE4S43 (([[UIScreen mainScreen]bounds].size.width)==320.0f && ([[UIScreen mainScreen]bounds].size.height)==480)
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * stateString,*stateString1, *urls;
    NSMutableArray * myObject;
    NSArray *data;
    NSString * title, *title2;
    NSDictionary * dictionary;
    UITableView * tableView1;
    NSArray * arrayTitle;
}
@end

@implementation DetailViewController
-(void) viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [[self navigationController]setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /*event swipe to right*/
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeHandler:)];
    [swipe setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:swipe];
    /**/
    [self ButtonNavigation];
    title2 = @"title1";
    urls= @"url1";
    myObject = [[NSMutableArray alloc]init];
    data = [[NSArray alloc]init];
     [self.tableView registerNib:[UINib nibWithNibName:@"Empty1" bundle:nil] forCellReuseIdentifier:@"Empty1"];
     [tableView1 registerNib:[UINib nibWithNibName:@"Empty" bundle:nil] forCellReuseIdentifier:@"Empty"];
       _tableView.backgroundColor = [UIColor clearColor];
   
    NSUserDefaults *defalut1 = [NSUserDefaults standardUserDefaults];
    NSString * temp = [defalut1 valueForKey:@"string1"];
    
    temp = [temp stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSURL *jsonURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://mic.duytan.edu.vn:88/SmartGardenAPI.svc/NTGHGetImage/%@",temp]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:jsonURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    NSData *responsedata = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* jsonData = [[NSString alloc] initWithData:responsedata encoding:NSUTF8StringEncoding];
    data = [jsonData componentsSeparatedByString:@"@"];

    if (IS_IPHONE6PLUS){[_image_bg setImage:[UIImage imageNamed:@"1280x1920"]];}
    else if(IS_IPHONE6){ [_image_bg setImage:[UIImage imageNamed:@"750x1334"]];}
    else if(IS_IPHONE5S5){[_image_bg setImage:[UIImage imageNamed:@"640x1136"]];}
    else if(IS_IPHONE4S43){[_image_bg setImage:[UIImage imageNamed:@"640x960"]];}
    
    arrayTitle = [defalut1 valueForKey:@"temp"];
    for(NSString *iteam in arrayTitle){
        NSArray * state = [iteam componentsSeparatedByString:@"@"];
        stateString = state[0];
        stateString = [stateString stringByReplacingOccurrencesOfString:@"-" withString:@" "];
        stateString = [stateString stringByReplacingOccurrencesOfString:[NSString stringWithFormat: @"<string xmlns=\"http://schemas.microsoft.com/2003/10/Serialization/\">"] withString:@""];
        stateString = [stateString stringByReplacingOccurrencesOfString:[NSString stringWithFormat: @"</string>"] withString:@""];
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      stateString,title2,
                      nil];
        [myObject addObject:dictionary];
    }
}
/*event swipeToRight*/
-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint Position = CGPointMake(self.view.frame.origin.x + 100.0, self.view.frame.origin.y);
            self.view.frame = CGRectMake(Position.x , Position.y , self.view.frame.size.width, self.view.frame.size.height);
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}
/**/
-(void)ButtonNavigation {
    NSUserDefaults * defaul = [NSUserDefaults standardUserDefaults];
    UIButton * btn_left = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    btn_left.backgroundColor = [UIColor colorWithRed:1.000 green:0.718 blue:0.012 alpha:1.00];
    btn_left.layer.masksToBounds = YES;
    btn_left.layer.cornerRadius = 4;
    [btn_left addTarget:self action:@selector(btn_left_Event:) forControlEvents:UIControlEventTouchUpInside];
    [btn_left setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    btn_left.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    UIBarButtonItem * barleft = [[UIBarButtonItem alloc]initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = barleft;
    
    UIButton * btn_right = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    btn_right.backgroundColor = [UIColor colorWithRed:1.000 green:0.718 blue:0.012 alpha:1.00];
    btn_right.layer.masksToBounds = YES;
    btn_right.layer.cornerRadius = 4;
  //  [btn_right addTarget:self action:@selector(btn_right_Event:) forControlEvents:UIControlEventTouchUpInside];
    [btn_right setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    btn_right.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    UIBarButtonItem * barright = [[UIBarButtonItem alloc]initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = barright;
    
    UIButton * btnTitle = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 250, 20)];
    btnTitle.backgroundColor = [UIColor colorWithRed:1.000 green:0.718 blue:0.012 alpha:1.00];
    btnTitle.layer.masksToBounds = YES;
    NSString * chappter = [defaul valueForKey:@"title"];
    NSArray * chapp = [chappter componentsSeparatedByString:@":"];
    NSString *titleBtn = chapp[0];

    
    
    [btnTitle setTitle:titleBtn forState:UIControlStateNormal];
    [btnTitle.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    btnTitle.layer.cornerRadius = 4;
    [btnTitle setImage:[UIImage imageNamed:@"DropdownArrowBrown"] forState:UIControlStateNormal];
    btnTitle.imageEdgeInsets = UIEdgeInsetsMake(5, 235, 5, 5);
    btnTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    [btnTitle addTarget:self action:@selector(btnTitle_Event:) forControlEvents:UIControlEventTouchUpInside];
    [btnTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnTitle.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    btnTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.navigationItem.titleView = btnTitle;
    
    UIView *subView= self.view;
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(_tableView.frame.origin.x+13, _tableView.frame.origin.y-5, _tableView.frame.size.width-26, 600) style:UITableViewStylePlain];
    tableView1.dataSource = self;
    tableView1.delegate = self;
    tableView1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView1.hidden = YES;
    tableView1.layer.masksToBounds = YES;
    tableView1.layer.cornerRadius = 10;
    tableView1.layer.borderWidth = 0.8;
    tableView1.layer.borderColor = [[UIColor grayColor]CGColor ];
    tableView1.backgroundColor = [UIColor blackColor];
    tableView1.alpha = 0.7;
    [tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    tableView1.separatorInset = UIEdgeInsetsMake (0, 0,0,15);
    [subView addSubview:tableView1];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(void)btnTitle_Event:(UIButton *)sender {
    if(tableView1.hidden == NO){
        tableView1.hidden = YES;
    }
    else if(tableView1.hidden == YES){
        tableView1.hidden = NO;
    }
}

-(void)btn_left_Event:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == tableView1){
        return [arrayTitle count];
    }
    NSLog(@"data cout %lu",(unsigned long)[data count]);

    return [data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == tableView1){
        TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Empty" forIndexPath:indexPath];
        if(indexPath.row == 0){
            cell.LableCell.text = @"ĐÓI QUÁ TRỜI ƠI";
        }
        NSDictionary *tmp = [myObject objectAtIndex:indexPath.row];
        NSString * stringForCell = [tmp objectForKeyedSubscript:title2];
        cell.LableCell.text = stringForCell;
        cell.iconCell.hidden = YES;
        cell.backgroundColor = [UIColor clearColor];
         return cell;
    }
    else if(tableView == _tableView){
    DetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Empty1" forIndexPath:indexPath];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data[indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
        NSLog(@"img %@",img);
        dispatch_async(dispatch_get_main_queue(), ^{
            DetailTableViewCell * cell1 = (DetailTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
             cell1.image.image = img;
            cell1.backgroundColor = [UIColor clearColor];
        });
    });
         return cell;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == tableView1){
        NSDictionary *tmpDict1 = [myObject objectAtIndex:indexPath.row];
        NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
        [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:title] forKey:@"title"];
        [defaults1 synchronize];
        [_tableView reloadData];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == tableView1){
        return 50;
    }
    return 400;
}


@end
