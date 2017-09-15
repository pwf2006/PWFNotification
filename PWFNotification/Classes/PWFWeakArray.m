//
//  PWFWeakArray.m
//  ViewTest
//
//  Created by pengweifeng on 2017/9/13.
//  Copyright © 2017年 pengweifeng. All rights reserved.
//

#import "PWFWeakArray.h"

@interface PWFWeakArray ()
/** 弱引用数组 */
@property (nonatomic, strong) NSPointerArray *pointerArr;

@end

@implementation PWFWeakArray

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.pointerArr = [NSPointerArray weakObjectsPointerArray];
    }
    
    return self;
}

- (void)addObject:(id)object {
    if (object == nil) {
        NSLog(@"to be added object can't be nil");
        return;
    }
    [self.pointerArr addPointer:(void *)object];
}

- (id)objectAtIndex:(NSUInteger)index {
    if ((self.count == 0) || index > self.count - 1) {
        return nil;
    }
    
    return [self.pointerArr pointerAtIndex:index];
}

- (NSArray *)allValidObjects {
    return self.pointerArr.allObjects;
}

- (NSUInteger)validCount {
    return self.pointerArr.allObjects.count;
}

- (NSUInteger)count {
    return self.pointerArr.count;
}

- (BOOL)isNullObjectAtIndex:(NSUInteger)index {
    if ((self.count == 0) || index > self.count - 1) {
        return YES;
    }
    
    return ([self.pointerArr pointerAtIndex:index] == nil);
}
@end
