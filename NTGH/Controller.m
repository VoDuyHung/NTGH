//
//  Controller.m
//  NTGH
//
//  Created by Võ Duy Hùng  on 7/5/16.
//  Copyright © 2016 Võ Duy Hùng . All rights reserved.
//

#import "Controller.h"
#import "TableViewCell.h"
#import "firtView.h"
#import "MBProgressHUD.h"
#define IS_IPHONE6PLUS (([[UIScreen mainScreen] bounds].size.width)==414.0f && ([[UIScreen mainScreen]  bounds].size.height)==736.0f)
#define IS_IPHONE6 (([[UIScreen mainScreen]bounds].size.width)==375.0f && ([[UIScreen mainScreen]bounds].size.height)==667.0f)
#define IS_IPHONE5S5 (([[UIScreen mainScreen]bounds].size.width)==320.0f && ([[UIScreen mainScreen]bounds].size.height)==568.0f)
#define IS_IPHONE4S43 (([[UIScreen mainScreen]bounds].size.width)==320.0f && ([[UIScreen mainScreen]bounds].size.height)==480)
@interface Controller ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,MBProgressHUDDelegate>{
    NSString * title;
    NSMutableArray *myObject,*abc;
    NSDictionary *dictionary;
    NSArray * temp,*namesArray;
    NSString *stateString,*stateString2;
    UISearchBar * searchBar;
    NSString * urls;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Controller{
   
}
-(void) viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[self navigationController]setNavigationBarHidden:NO animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self interface];
    self.tableView.tableFooterView = [[UIView alloc]init];
    /*event swipe to right*/
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeHandler:)];
    [swipe setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:swipe];
    /**/
    myObject = [[NSMutableArray alloc] init];
    title = @"title";
    urls = @"url";
    _tableView.separatorColor = [UIColor colorWithRed:1.000 green:0.718 blue:0.012 alpha:0.5];
    _tableView.backgroundColor = [UIColor clearColor];
   [self.tableView registerNib:[UINib nibWithNibName:@"Empty" bundle:nil] forCellReuseIdentifier:@"Empty"];
    NSUserDefaults  * de = [NSUserDefaults standardUserDefaults];
    NSString * TEST = @"TEST";
    [de setObject:TEST forKey:@"test"];
   temp = [de valueForKey: @"temp"];
    [de synchronize];
    for(NSString *iteam in temp){
        NSUInteger lang = [iteam length];
        NSArray * state = [iteam componentsSeparatedByString:@"@"];
        if(lang < 10){
            NSLog(@"NULL");
        }
        else{
        stateString2 = state[1];
        }
        stateString = state[0];
        stateString = [stateString stringByReplacingOccurrencesOfString:@"-" withString:@" "];
         stateString = [stateString stringByReplacingOccurrencesOfString:[NSString stringWithFormat: @"<string xmlns=\"http://schemas.microsoft.com/2003/10/Serialization/\">"] withString:@""];
        stateString = [stateString stringByReplacingOccurrencesOfString:[NSString stringWithFormat: @"</string>"] withString:@""];
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                     stateString,title,
                      stateString2,urls,
                      nil];
        [myObject addObject:dictionary];
        _filteredTableData = [[NSMutableArray alloc]init];
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

-(void)interface {
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarIconSearch;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.keyboardType = UIKeyboardTypeAlphabet;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.placeholder=@"Tìm kiếm chương...";
    searchBar.barTintColor = [UIColor yellowColor];
    searchBar.tintColor = [UIColor colorWithRed:0.996 green:0.722 blue:0.012 alpha:1.00];
    [[UITextField appearanceWhenContainedIn:[searchBar class], nil]setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithCustomView:searchBar];

    UIButton *btn_back =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_back setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [btn_back setFrame:CGRectMake(0, 0, 20, 20)];
    [btn_back addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:btn_back];
    
    NSArray *arrayButtonLeft= [[NSArray alloc] initWithObjects:barButton,search, nil];
    
    self.navigationItem.leftBarButtonItems=arrayButtonLeft;
    //turn off border for navigationbar
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    if (IS_IPHONE6PLUS){[_img_bg setImage:[UIImage imageNamed:@"1280x1920"]];}
    else if(IS_IPHONE6){ [_img_bg setImage:[UIImage imageNamed:@"750x1334"]];}
    else if(IS_IPHONE5S5){[_img_bg setImage:[UIImage imageNamed:@"640x1136"]];}
    else if(IS_IPHONE4S43){[_img_bg setImage:[UIImage imageNamed:@"640x960"]];}

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger rowCount;
    if(_isFiltered){
        rowCount = _filteredTableData.count;
    }
    else rowCount = [temp count];
    return rowCount;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Empty" forIndexPath:indexPath];
    NSDictionary *tmpDict= [myObject objectAtIndex:indexPath.section];
    if(_isFiltered){
        tmpDict = [_filteredTableData objectAtIndex:indexPath.section];
    }
    else {
        tmpDict = [myObject objectAtIndex:indexPath.section];
    }
    cell.LableCell.text = [tmpDict objectForKeyedSubscript:title];
    cell.backgroundColor = [UIColor clearColor];
    cell.LableCell.highlightedTextColor = [UIColor colorWithRed:1.000 green:0.722 blue:0.012 alpha:1.00];
    /*Thay đổi màu cell when selected.*/
    UIView *selectionColor= [[UIView alloc]initWithFrame:CGRectMake(5, 5, 200, 30)];
    selectionColor.backgroundColor =[UIColor colorWithRed:0.067 green:0.059 blue:0.055 alpha:0.3];
    cell.selectedBackgroundView = selectionColor;
    /**/
    return cell;
}
/*SEARCH EVENT*/
-(void)searchBar:(UISearchBar *)searchbar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        _isFiltered = false;
        [searchBar resignFirstResponder];
    }
    else {
        _isFiltered = true;
        _filteredTableData = [[NSMutableArray alloc]init];
        NSPredicate * resultPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@",searchText];
        _filteredTableData = [myObject filteredArrayUsingPredicate:resultPredicate];
    }
    [_tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchbar
{
    
    
    [ searchBar  setSearchResultsButtonSelected:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud2= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud2.labelText = @"Đang tìm kiếm...";
        hud2.dimBackground = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [ searchBar  resignFirstResponder];
            [_tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
    });
    
}
/*- (void)searchBarTextDidEndEditing:(UISearchBar *)searchbar{
    searchBar.showsCancelButton = YES;
    [searchBar setShowsCancelButton:YES animated:YES];
    UIView *view = searchBar.subviews[0];
    for(UIView * subview in view.subviews){
        if([subview isKindOfClass:[UIButton class]]){
            UIButton * cancleButton= (UIButton*)subview;
            [cancleButton setTitle:@"Đóng" forState:UIControlStateNormal];
        }
    }
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchbar{
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    _isFiltered = FALSE;
    [_tableView reloadData];
}*/
/**/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)backButton:(UIButton *)btn{
  
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *tmpDict1 = [myObject objectAtIndex:indexPath.section];
    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:urls] forKey:@"string1"];
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:title] forKey:@"title"];
    [defaults1 synchronize];
    [self performSegueWithIdentifier:@"detailBook" sender:self];
}

@end
