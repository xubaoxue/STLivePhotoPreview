//
//  ViewController.m
//  huoying
//
//  Created by study on 2017/3/10.
//  Copyright © 2017年 Study. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) PHLivePhotoView *photoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 30, 200, 30)];
    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"选取图片" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchDown];
    
    
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(100,self.view.bounds.size.height - 50, 200, 20)];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"重新播放" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchDown];
}

- (void)button1Click:(UIButton *)sender {
    //创建图片控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    //设置控制器类型
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    // 设置mediaTypes 添加LivePhoto类型图片
    NSArray *mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeLivePhoto];
    ipc.mediaTypes = mediaTypes;
    [self presentViewController:ipc animated:YES completion:^{
    }];
}

- (PHLivePhotoView*)photoView {
    if (!_photoView) {
        _photoView = [[PHLivePhotoView alloc]initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, self.view.bounds.size.height - 150)];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.clipsToBounds = YES;
    }
    return _photoView;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"%@",info);
        PHLivePhoto *photo = [info objectForKey:UIImagePickerControllerLivePhoto];
        if (photo) {
            [self.view addSubview:self.photoView];
            _photoView.livePhoto = [info objectForKey:UIImagePickerControllerLivePhoto];
            [_photoView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleFull];
        } else {
            NSLog(@"普通图片");
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)button2Click:(UIButton*)sender {
    [_photoView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleFull];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
