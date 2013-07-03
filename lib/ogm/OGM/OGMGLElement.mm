//
//  OGMGLElement.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/09.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLElement.h"
#import "OGMErrorUtil.h"

@implementation OGMGLElement

-(id)init{
	self = [super init];
	if(self){
		_transform = [[OGMGLMatrixStack alloc]init];
	}
	return self;
}

-(void)renderWithRenderer:(OGMGLRenderer *)renderer{
	[renderer dispatchElementRender:self];
}

@end
