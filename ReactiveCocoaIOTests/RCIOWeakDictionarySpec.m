//
//  RCIOWeakDictionarySpec.m
//  ReactiveCocoaIO
//
//  Created by Uri Baghin on 16/01/2013.
//  Copyright (c) 2013 Enthusiastic Code. All rights reserved.
//

#import "RCIOWeakDictionary.h"

SpecBegin(RCIOWeakDictionary)

describe(@"RCIOWeakDictionary", ^{
	__block RCIOWeakDictionary *dictionary = nil;
	id key = @"test key";
	
	before(^{
		dictionary = [[RCIOWeakDictionary alloc] init];
	});
	
	it(@"should store objects", ^{
		id object = [[NSObject alloc] init];
		dictionary[key] = object;
		expect(dictionary[key]).to.beIdenticalTo(object);
	});
	
	it(@"should let objects deallocate", ^{
		__block BOOL deallocd = NO;
		
		@autoreleasepool {
			id object = [[NSObject alloc] init];
			[object rac_addDeallocDisposable:[RACDisposable disposableWithBlock:^{
				deallocd = YES;
			}]];
			dictionary[key] = object;
			expect(dictionary[key]).to.beIdenticalTo(object);
		}
		
		expect(deallocd).will.beTruthy();
		expect(dictionary[key]).will.beNil();
	});
});

SpecEnd
