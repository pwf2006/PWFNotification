//
//  PWFWeakArray.h
//  ViewTest
//
//  Created by pengweifeng on 2017/9/13.
//  Copyright © 2017年 pengweifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWFWeakArray : NSObject
/** 数组中所有有效的对象 */
@property (nonatomic, strong, readonly) NSArray *allValidObjects;

/** 数组中所有有效对象的个数 */
@property (nonatomic, assign, readonly) NSUInteger validCount;

/** 数组中所有对象的个数,包括NULL */
@property (nonatomic, assign, readonly) NSUInteger count;

/**
 向弱引用数组中添加一个对象

 @param object 要添加的对象
 */
- (void)addObject:(id)object;

/**
 获取数组中指定索引的对象包括NULL

 @param index 数组下标
 @return index 索引对应的对象
 */
- (id)objectAtIndex:(NSUInteger)index;

/**
 判断索引为index的对象是否为NULL

 @param index 数组索引
 @return YES:是空对象;NO:不是空对象
 */
- (BOOL)isNullObjectAtIndex:(NSUInteger)index;

@end
