//
//  QECacheManager.m
//  QnuaElf
//
//  Created by hscai on 2019/4/2.
//  Copyright © 2019 YJL. All rights reserved.
//

#import "QECacheManager.h"
#import "QECacheConst.h"

@implementation QECacheManager

+ (void)limitSetting{
    YYMemoryCache *memoryCache = [YYWebImageManager sharedManager].cache.memoryCache;//获取内存缓存
    memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;//内存警告的时候删除所有内容
    memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;//进入后台删除所有内容
    memoryCache.countLimit = QECacheMemoryMax;//80M
    memoryCache.costLimit = QECacheMemoryMax;//80M
    memoryCache.ageLimit = QECacheAgeLimit;//cache存在的时间限制设置
    
    YYDiskCache *diskCache = [YYWebImageManager sharedManager].cache.diskCache;
    diskCache.freeDiskSpaceLimit = QECacheDiskMax; // 100M
    diskCache.ageLimit = QECacheAgeLimit;
    diskCache.countLimit = QECacheDiskMax;//80M
    diskCache.costLimit = QECacheDiskMax;//80M
}

// 电商应用没必要缓存图片到本地，因为图片随时都在变化，所以在退出应用以后全部删除
+ (void)removeAllCache{
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    [cache.diskCache removeAllObjects];
    [cache.memoryCache removeAllObjects];
}

+ (NSUInteger)cacheTotalCost{
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    NSUInteger diskCost = cache.diskCache.totalCost;
    NSUInteger meoryCost = cache.memoryCache.totalCost;
    
    NSUInteger totalCost = diskCost + meoryCost;
    return totalCost;
}

@end
