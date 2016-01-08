//
//  LSSSendMessageViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSSendMessageViewController.h"
#import "UMSocial.h"
#import "LSSMapViewController.h"
@interface LSSSendMessageViewController () <UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UMSocialUIDelegate> {

    UITextView* _contentText;
    UIImageView* _addimageV;

    BOOL _isCurrImage; //判断是否上传图片

    UIImageView* _footerV;
    UILabel* _label; //提示信息
    
    UIView* _view;
    
    UIImageView* _mapV;
    UILabel* _mapL;
    
}

@end

@implementation LSSSendMessageViewController

- (void)viewDidLoad
{
    _isCurrImage = YES;
    [super viewDidLoad];
    [self setNaviBar];
    [self createUI];
}
- (void)setNaviBar
{
    self.view.backgroundColor = [UIColor colorWithRed:0.878 green:0.940 blue:0.946 alpha:1.000];
    self.sc_navigationItem.title = @"记录宝宝成长";
    __weak typeof(self) weakSelf = self;
    SCBarButtonItem* back = [[SCBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward"]
                                                             style:SCBarButtonItemStylePlain
                                                           handler:^(id sender) {
                                                               [weakSelf.navigationController popViewControllerAnimated:YES];
                                                           }];
    SCBarButtonItem* send = [[SCBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"send"]
                                                             style:SCBarButtonItemStylePlain
                                                           handler:^(id sender) {
                                                               [self sendMessage];
                                                           }];
    self.sc_navigationItem.leftBarButtonItem = back;
    self.sc_navigationItem.rightBarButtonItem = send;
}
- (void)sendMessage

{
    //当再次输入点击发送的时候调用
    [_label removeFromSuperview];

    _label = [[UILabel alloc] initWithFrame:CGRectMake(Screen_size.width / 4, Screen_size.height / 4, 300, 30)];
    _label.textColor = Base_Color;
    _label.text = @"您还没有上传文字内容哦~~";

    if ([_contentText.text isEqual:@""]) {

        [self.view addSubview:_label];
    }
    else {

        [_label removeFromSuperview];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"分享到新浪微博", @"保存到本地", nil];

        [alert show];
    }
}
#pragma mark---分享的alert点击事件
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //取消
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (buttonIndex == 1) {
        //微博
        [self sendToSina];
    }
    else {
        //本地
        [self sendToLocal];
    }
}

- (void)sendToSina
{

    UIImage* image;
    if (_isCurrImage) {
        image = nil;
    }
    else {
        image = _addimageV.image;
    }
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5647f36167e58edc2d005e3b"
                                      shareText:_contentText.text
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina, nil]
                                       delegate:self];
}

- (void)sendToLocal
{

    UIImage* image;
    if (_isCurrImage) {
        image = nil;
    }
    else {
        image = _addimageV.image;
    }
#warning 获取当前的时间
    //1.创建一个时间 格林尼治时间
    NSDate* date = [NSDate date];
    //返回八小时是现在的时间
    date = [NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60]; //参数是秒

    NSData* imageData = UIImageJPEGRepresentation(image, 8);
    LSSDBManager* manager = [LSSDBManager defaultDBManager];
    LSSMineBabyModel* mo = [[LSSMineBabyModel alloc] init];
    mo.babyContent = _contentText.text;
    mo.imageData = imageData;
    mo.babyDate = [NSString stringWithFormat:@"%@", date];

    [manager addMessage:mo];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"发送通知" message:@"保存成功!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];

    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark--创建UI
- (void)createUI
{
    _contentText = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, Screen_size.width, Screen_size.height / 2 - 64 - 49)];

    _contentText.delegate = self;
    _contentText.textAlignment = NSTextAlignmentLeft;
    _contentText.text = @"  记录宝宝成长瞬间.....";
    _contentText.font = [UIFont systemFontOfSize:17];
    _contentText.textColor = [UIColor grayColor];
    _contentText.layer.cornerRadius = 25;
    _contentText.layer.masksToBounds = YES;
    //父类里面设置光标的颜色
    _contentText.tintColor=[UIColor blackColor];
    
    [self.view addSubview:_contentText];

    _addimageV = [[UIImageView alloc] init];
    _addimageV.image = [UIImage imageNamed:@"add"];
    _addimageV.userInteractionEnabled = YES;

    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionSheet:)];
    [_addimageV addGestureRecognizer:tap];
    [_contentText addSubview:_addimageV];

#warning 脚图
    _footerV = [[UIImageView alloc] init];
    _footerV.image = [UIImage imageNamed:@"note_bg"];
    [self.view addSubview:_footerV];

#warning 约束
    UIView* superV = _contentText;
    CGFloat padding = 20;

    [_addimageV makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(superV.mas_left).offset(padding);
        make.bottom.equalTo(_footerV.mas_top).offset(-padding);
        make.size.equalTo(CGSizeMake(70, 70));

    }];
    [_footerV makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.equalTo(superV.mas_bottom).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    
#warning 地图的view
    _view = [[UIView alloc] init];
    _view.userInteractionEnabled = YES;
    _view.layer.borderColor = [UIColor colorWithRed:0.704 green:0.664 blue:0.695 alpha:1.000].CGColor;
    _view.layer.borderWidth = 1;
    _view.layer.cornerRadius = 15;
    _view.layer.masksToBounds = YES;
    
    UITapGestureRecognizer* mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapAction:)];
    [_view addGestureRecognizer:mapTap];
    [self.view addSubview:_view];
    
    _mapV = [[UIImageView alloc] init];
    _mapV.image = [UIImage imageNamed:@"map"];
    [_view addSubview:_mapV];
    
    _mapL = [[UILabel alloc] init];
    _mapL.text = @"我在这里";
    _mapL.font = [UIFont systemFontOfSize:14];
    _mapL.textColor = [UIColor grayColor];
    [_view addSubview:_mapL];
    
    [_view makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(superV.mas_left).offset(padding - 5);
        make.top.equalTo(superV.mas_bottom).offset(padding / 2);
        make.size.equalTo(CGSizeMake(100, 30));
    }];
    
    UIView* subV = _view;
    CGFloat padding1 = 5;
    [_mapV makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(subV.mas_left).offset(padding1);
        make.top.equalTo(subV.mas_top).offset(padding1);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    [_mapL makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(_mapV.mas_right).offset(padding1 * 2);
        make.top.equalTo(subV.mas_top).offset(0);
        make.size.equalTo(CGSizeMake(65, 30));
    }];
}
#pragma mark---显示地图定位
- (void)mapAction:(UITapGestureRecognizer*)mapTap
{
    LSSMapViewController * mapV=[[LSSMapViewController alloc]init];
    [self.navigationController pushViewController:mapV animated:YES];
    
   
}

#pragma mark---选择图片的手势事件
- (void)actionSheet:(UITapGestureRecognizer*)tap
{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [sheet showInView:_contentText];
}

#pragma mark--UIActionSheetDelegate 选择图片的代理方法
- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //拍照
        [self openCamera];
    }
    else if (buttonIndex == 1) {
        //从相册获取
        [self openAlbum];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)openCamera
{
    UIImagePickerController* pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.delegate = self;
    //设置打开相册的类型
    pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    //显示出相册
    [self presentViewController:pickerVC animated:YES completion:nil];
}
- (void)openAlbum
{
    UIImagePickerController* pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.delegate = self;
    //设置打开相册的类型
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //显示出相册
    [self presentViewController:pickerVC animated:YES completion:nil];
}
#pragma mark--UIImagePickerControllerDelegate 图片选择完成的协议代理方法
//点击图片调用 拍完照
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString*, id>*)info
{
    _isCurrImage = NO;
    //获取原始图片
    UIImage* image = info[UIImagePickerControllerOriginalImage];
    //获取编辑过的照片
    //   UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    _addimageV.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark---设置键盘收回
- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
    [self.view endEditing:YES];
}
#pragma mark---textView协议方法
- (void)textViewDidBeginEditing:(UITextView*)textView
{
    _contentText.text = @"";
}

#pragma mark--友盟分享的协议方法
- (BOOL)isDirectShareInIconActionSheet
{
    return NO;
}
/**
 自定义关闭授权页面事件
 
 @param navigationCtroller 关闭当前页面的navigationCtroller对象
 
 */
-(BOOL)closeOauthWebViewController:(UINavigationController *)navigationCtroller socialControllerService:(UMSocialControllerService *)socialControllerService{
    return YES;
}
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity*)response
{
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"发送通知" message:@"分享成功!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alert show];
    //[self.navigationController popViewControllerAnimated:YES];
   // [self dismissViewControllerAnimated:YES completion:nil];
}

@end
