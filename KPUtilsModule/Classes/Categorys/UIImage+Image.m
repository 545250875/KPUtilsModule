//
//  UIImage+Image.m
//  
//
//  Created by FRAJ on 16/2/18.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "UIImage+Image.h"
#import <Photos/Photos.h>

@implementation UIImage (Image)

+ (UIImage *)imageNameWithOriginalMode:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    // imageWithRenderingMode:返回一个没有被渲染的图片
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+(instancetype)fj_circleImageNamed:(NSString *)name{
    
    return [[self imageNamed:name] fj_circleImage];
}

-(instancetype)fj_circleImage{
    
    //1.开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.描述剪裁区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //3.设置剪裁区域
    [clipPath addClip];
    //4.绘制图片
    [self drawAtPoint:CGPointZero];
    //5.从上下文中取出图片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}

#pragma mark - 保存图片至相册
- (void)fj_saveToCustomAlbumWithCompletionHandler:(void(^)(BOOL, NSError *))handler{
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    // 判断当前的授权状态
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
                // 这是系统级别的限制（比如家长控制），用户也无法修改这个授权状态
            case PHAuthorizationStatusRestricted: {

                handler(NO, [NSError errorWithDomain:@"系统级别限制" code:0 userInfo:nil]);
                break;
            }
                
                // 用户已经拒绝当前App访问相片数据（说明用户当初选择了“Don't Allow”）
            case PHAuthorizationStatusDenied: {
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                   handler(NO, [NSError errorWithDomain:@"用户拒绝访问" code:1 userInfo:nil]);
                }
                break;
            }
                
                // 用户已经允许当前App访问相片数据（说明用户当初选择了“OK”）
            case PHAuthorizationStatusAuthorized: {

                //获得自定义相册
                PHAssetCollection *createdCollection = self.createdCollection;
                
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    // 保存图片到【相机胶卷】
                    // createdAsset 就代表 刚才添加到【相机胶卷】中的图片
                    PHObjectPlaceholder *createdAsset = [PHAssetChangeRequest creationRequestForAssetFromImage:self].placeholderForCreatedAsset;
                    // 将对应的相册传入，创建一个【相册修改请求】对象
                    PHAssetCollectionChangeRequest *collectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
                    // 将保存到【相机胶卷】的图片添加到【自定义相册】
                    [collectionChangeRequest insertAssets:@[createdAsset] atIndexes:[NSIndexSet indexSetWithIndex:0]];
                    
                } completionHandler:handler];
                
                break;
            }
                
            default:
                break;
        }
    }];
    
    
}

-(PHAssetCollection *)createdCollection{
    // 抓取所有【自定义相册】
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 从Info.plist中获得App名称(也就是当前App的相册名称)
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            // 【自定义相册】已经创建过
            return collection;
        }
    }
    
    __block NSString *collectionId = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 创建【自定义相册】
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    // 根据id获得刚刚创建完的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}


@end
