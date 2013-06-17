//
//  OGMGLRenderer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/16.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLRenderer.h"

#import "OGMErrorUtil.h"
#import "OGMGLElement.h"



@implementation OGMGLRenderer

-(id)init{
	self = [super init];
	if(self){
		_projection = [[OGMGLMatrixStack alloc]init];
		_modelView = [[OGMGLMatrixStack alloc]init];
	}
	return self;
}


-(void)dispatchElementRender:(OGMGLElement *)element{
	@throw OGMExceptionMake(NSGenericException,@"can't render this element");
}

-(void)render{
	@throw OGMExceptionMake(NSGenericException,@"unimplemented");
}

@end
