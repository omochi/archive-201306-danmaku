//
//  OGMGLReleaser.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/05.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLReleaser.h"
#import "OGMErrorUtil.h"

@interface OGMGLReleaser()
@property(nonatomic,strong)NSOperationQueue *operationQueue;
@property(nonatomic,strong)EAGLContext *glContext;
@property(nonatomic,strong)NSMutableArray *releaserList;
@end

@implementation OGMGLReleaser

- (id)init
{
    self = [super init];
    if (self) {
		_releaserList = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc{
	if(self.operationQueue){
		NSArray * releaserList = self.releaserList;
		EAGLContext * glContext = self.glContext;
		[self.operationQueue addOperationWithBlock:^{
			EAGLContext * oldContext = [EAGLContext currentContext];			
			[EAGLContext setCurrentContext:glContext];
			for(dispatch_block_t releaser in releaserList){
				releaser();
			}
			[EAGLContext setCurrentContext:oldContext];
		}];
	}
}

-(void)capture:(dispatch_block_t)releaser{
	if(self.operationQueue){
		@throw OGMExceptionMake(NSGenericException, @"already captured");
	}
	self.operationQueue = [NSOperationQueue currentQueue];
	if(!self.operationQueue){
		@throw OGMExceptionMake(NSGenericException, @"not exists operation queue in this thread");
	}
	self.glContext = [EAGLContext currentContext];
	if(!self.glContext){
		@throw OGMExceptionMake(NSGenericException, @"get gl context failed");
	}
	[self addReleaser:releaser];
}

-(void)addReleaser:(dispatch_block_t)releaser{
	[self.releaserList addObject:[releaser copy]];
}

@end
