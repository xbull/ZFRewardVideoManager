//
//  NSOrderedSet+FirstObject.m
//
//  Created by Benjamin Baron on 8/7/13.
//
//

#import "NSOrderedSet+FirstObject.h"
#import "NSOrderedSet+Safe.h"

@implementation NSOrderedSet (FirstObject)

- (id)firstObject
{
    if (self.count == 0) {
        return nil;
    }
	return [self objectAtIndex:0];
}

- (id)firstObjectSafe
{
	return [self objectAtIndexSafe:0];
}

@end
