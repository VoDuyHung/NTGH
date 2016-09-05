//
//  firtView.m
//  NTGH
//
//  Created by Võ Duy Hùng  on 8/16/16.
//  Copyright © 2016 Võ Duy Hùng . All rights reserved.
//

#import "firtView.h"

@interface firtView ()<UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>
{
    NSTimer * myTimer;
    NSString * title,* urls;
    NSMutableArray *myObject,*abc;
    NSDictionary *dictionary;
    NSArray * temp,*namesArray,*data;
    NSString *stateString,*stateString2;
}
@end

@implementation firtView
-(void) viewWillAppear:(BOOL)animated
{
    [[self navigationController]setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    myObject = [[NSMutableArray alloc] init];
    title = @"title";
     urls = @"url";
    NSURL *jsonURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://mic.duytan.edu.vn:88/SmartGardenAPI.svc/NTGHGetChapterV2/",nil]];
    NSURLRequest *request = [NSURLRequest requestWithURL:jsonURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    NSData *responsedata = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* jsonData = [[NSString alloc] initWithData:responsedata encoding:NSUTF8StringEncoding];
    temp = [jsonData componentsSeparatedByString:@"_"];
    NSUserDefaults  * de = [NSUserDefaults standardUserDefaults];
    [de setObject:temp forKey:@"temp"];
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
    }
    
    _scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGFloat scrollViewHeight = self.view.frame.size.height;
    CGFloat scrollViewWidth = self.view.frame.size.width;
    
    
    NSDictionary * tmpdict = [myObject objectAtIndex:0];
    NSString * tit = [tmpdict objectForKeyedSubscript:title];
    NSString * url = [tmpdict objectForKeyedSubscript:urls];
    
    tmpdict = [myObject objectAtIndex:1];
    NSString * tit1 = [tmpdict objectForKeyedSubscript:title];
    NSString * url1 = [tmpdict objectForKeyedSubscript:urls];
    
    tmpdict = [myObject objectAtIndex:2];
    NSString * tit2 = [tmpdict objectForKeyedSubscript:title];
    NSString * url2 = [tmpdict objectForKeyedSubscript:urls];
    
    tmpdict = [myObject objectAtIndex:3];
    NSString * tit3 = [tmpdict objectForKeyedSubscript:title];
    NSString * url3 = [tmpdict objectForKeyedSubscript:urls];
    
    data = [[NSArray alloc]init];
    url = [url stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSURL *jsonURL1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://mic.duytan.edu.vn:88/SmartGardenAPI.svc/NTGHGetImage/%@",url]];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:jsonURL1 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    NSData *responsedata1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:nil];
    NSString* jsonData1 = [[NSString alloc] initWithData:responsedata1 encoding:NSUTF8StringEncoding];
    data = [jsonData1 componentsSeparatedByString:@"@"];
   // [UD setObject:data forKey:];
    
    url1 = [url1 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSURL *jsonURL2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://mic.duytan.edu.vn:88/SmartGardenAPI.svc/NTGHGetImage/%@",url1]];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:jsonURL2 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    NSData *responsedata2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
    NSString* jsonData2 = [[NSString alloc] initWithData:responsedata2 encoding:NSUTF8StringEncoding];
    NSArray * data1 = [jsonData2 componentsSeparatedByString:@"@"];
    
    url2 = [url2 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSURL *jsonURL3 = [NSURL URLWithString:[NSString stringWithFormat:@"http://mic.duytan.edu.vn:88/SmartGardenAPI.svc/NTGHGetImage/%@",url2]];
    NSURLRequest *request3 = [NSURLRequest requestWithURL:jsonURL3 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    NSData *responsedata3= [NSURLConnection sendSynchronousRequest:request3 returningResponse:nil error:nil];
    NSString* jsonData3 = [[NSString alloc] initWithData:responsedata3 encoding:NSUTF8StringEncoding];
    NSArray * data2 = [jsonData3 componentsSeparatedByString:@"@"];

    url3 = [url3 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSURL *jsonURL4 = [NSURL URLWithString:[NSString stringWithFormat:@"http://mic.duytan.edu.vn:88/SmartGardenAPI.svc/NTGHGetImage/%@",url3]];
    NSURLRequest *request4 = [NSURLRequest requestWithURL:jsonURL4 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    NSData *responsedata4= [NSURLConnection sendSynchronousRequest:request4 returningResponse:nil error:nil];
    NSString* jsonData4 = [[NSString alloc] initWithData:responsedata4 encoding:NSUTF8StringEncoding];
    NSArray * data3 = [jsonData4 componentsSeparatedByString:@"@"];
    //////////////

    
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0,170, 160, 60)];
    titleLbl.text = tit;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor colorWithRed:1.000 green:0.718 blue:0.012 alpha:1.00];
    titleLbl.backgroundColor = [UIColor blackColor];
    titleLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    titleLbl.alpha = 0.7;
    titleLbl.numberOfLines = 2;
    
    UILabel * titleLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0,170, 160, 60)];
    titleLbl1.text = tit1;
    titleLbl1.textAlignment = NSTextAlignmentCenter;
    titleLbl1.textColor = [UIColor colorWithRed:1.000 green:0.718 blue:0.012 alpha:1.00];
    titleLbl1.backgroundColor = [UIColor blackColor];
    titleLbl1.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    titleLbl1.alpha = 0.7;
    titleLbl1.numberOfLines = 2;
    
    UILabel * titleLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(0,170, 160, 60)];
    titleLbl2.text = tit2;
    titleLbl2.textAlignment = NSTextAlignmentCenter;
    titleLbl2.textColor = [UIColor colorWithRed:1.000 green:0.718 blue:0.012 alpha:1.00];
    titleLbl2.backgroundColor = [UIColor blackColor];
    titleLbl2.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    titleLbl2.alpha = 0.7;
    titleLbl2.numberOfLines = 2;
    
    UILabel * titleLbl3 = [[UILabel alloc]initWithFrame:CGRectMake(0,170, 160, 60)];
    titleLbl3.text = tit3;
    titleLbl3.textAlignment = NSTextAlignmentCenter;
    titleLbl3.textColor = [UIColor colorWithRed:1.000 green:0.718 blue:0.012 alpha:1.00];
    titleLbl3.backgroundColor = [UIColor blackColor];
    titleLbl3.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    titleLbl3.alpha = 0.7;
    titleLbl3.numberOfLines = 2;
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 190, 160, 230)];
    UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    image.image = img;
    UITapGestureRecognizer *singeTapImage= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    singeTapImage.numberOfTapsRequired = 1;
    [image setUserInteractionEnabled:YES];
    [image addGestureRecognizer:singeTapImage];
    
    UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake(160+35, 190, 160, 230)];
    UIImage * img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data1[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    image1.image = img1;
    UITapGestureRecognizer *singeTapImage1= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage1:)];
    singeTapImage1.numberOfTapsRequired = 1;
    [image1 setUserInteractionEnabled:YES];
    [image1 addGestureRecognizer:singeTapImage1];
    
    UIImageView * image2 = [[UIImageView alloc]initWithFrame:CGRectMake(scrollViewWidth+20, 190, 160, 230)];
    UIImage * img2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data2[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    image2.image = img2;
    UITapGestureRecognizer *singeTapImage2= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage2:)];
    singeTapImage2.numberOfTapsRequired = 1;
    [image2 setUserInteractionEnabled:YES];
    [image2 addGestureRecognizer:singeTapImage2];
    
    UIImageView * image3 = [[UIImageView alloc]initWithFrame:CGRectMake(scrollViewWidth+160+35, 190, 160, 230)];
    UIImage * img3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data3[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    image3.image = img3;
    UITapGestureRecognizer *singeTapImage3= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage3:)];
    singeTapImage3.numberOfTapsRequired = 1;
    [image3 setUserInteractionEnabled:YES];
    [image3 addGestureRecognizer:singeTapImage3];
    
    UILabel * TieuDe = [[UILabel alloc]initWithFrame:CGRectMake(40,10, 300, 150)];
    TieuDe.text = @"Người Trong \n Giang Hồ";
    TieuDe.textAlignment = NSTextAlignmentCenter;
    TieuDe.textColor = [UIColor colorWithRed:1.000 green:0.718 blue:0.012 alpha:1.00];
    TieuDe.font = [UIFont fontWithName:@"SnellRoundhand-Bold" size:50];
    TieuDe.numberOfLines = 3;
    [self.view addSubview:TieuDe];
    [image1 addSubview:titleLbl1];
    [image addSubview:titleLbl];
    [image2 addSubview:titleLbl2];
    [image3 addSubview:titleLbl3];
    [_scrollView addSubview:image];
    [_scrollView addSubview:image1];
    [_scrollView addSubview:image2];
    [_scrollView addSubview:image3];
    
    _scrollView.contentSize = CGSizeMake(scrollViewWidth*2, scrollViewHeight);
    _scrollView.delegate = self;
    _pageControl.currentPage = 0;
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(tagetMethod:) userInfo:nil repeats:true];
}
-(void)tapImage:(UIGestureRecognizer*)gestureRecognizer{
    NSLog(@"tap tap tap");
}
-(void)tapImage1:(UIGestureRecognizer*)gestureRecognizer{
    NSLog(@"tap tap tap1");
}
-(void)tapImage2:(UIGestureRecognizer*)gestureRecognizer{
    NSLog(@"tap tap tap2");
}
-(void)tapImage3:(UIGestureRecognizer*)gestureRecognizer{
    NSLog(@"tap tap tap3");
}

- (void)tagetMethod:(NSTimer*)timer {
    CGFloat pageWidth= CGRectGetWidth(_scrollView.frame);
    CGFloat maxWidth= pageWidth * 2;
    CGFloat contentOffSet = _scrollView.contentOffset.x;
    NSInteger slideToX= contentOffSet + pageWidth;
    if(contentOffSet+pageWidth == maxWidth){
        slideToX = 0;
    }
    [_scrollView scrollRectToVisible:(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(_scrollView.frame))) animated: true];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat pageWidth= CGRectGetWidth(scrollView.frame);
    CGFloat currentPage = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    _pageControl.currentPage = (int)currentPage;
    if((int)currentPage == 0){
    }
    else if((int)currentPage==1){
    }
}
- (IBAction)btn_start:(id)sender {
    [self performSegueWithIdentifier:@"xemTruyen" sender:self];
    /*[myTimer invalidate];
    myTimer = nil;*/
}

- (IBAction)btn_taiDanhSach:(id)sender {
}
@end
