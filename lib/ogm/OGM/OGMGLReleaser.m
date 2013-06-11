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
			if(oldContext != glContext){
				glFlush();
				[EAGLContext setCurrentContext:glContext];
			}
			for(dispatch_block_t releaser in releaserList){
				releaser();
			}
			if(oldContext != glContext){
				glFlush();
				[EAGLContext setCurrentContext:oldContext];
			}
		}];
	}
}

-(void)setOperationQueue:(NSOperationQueue *)operationQueue{
	if(_operationQueue && _operationQueue != operationQueue){
		@throw OGMExceptionMake(NSGenericException, @"already bound to other thread");
	}
	_operationQueue = operationQueue;
}
-(void)setGlContext:(EAGLContext *)glContext{
	if(_glContext && _glContext != glContext){
		@throw OGMExceptionMake(NSGenericException, @"already bound to other gl context");
	}
	_glContext = glContext;
}
-(void)addReleaser:(OGMWeakSelfBlock)releaser self:(id)aSelf{
	self.operationQueue = [NSOperationQueue currentQueue];
	if(!self.operationQueue){
		@throw OGMExceptionMake(NSGenericException, @"not exists operation queue in this thread");
	}
	
	self.glContext = [EAGLContext currentContext];
	if(!self.glContext){
		@throw OGMExceptionMake(NSGenericException, @"not exists gl context in this thread");
	}
	
	[self.releaserList addObject:OGMWeakSelfBlockBindSelf(releaser, aSelf)];
}


@end
