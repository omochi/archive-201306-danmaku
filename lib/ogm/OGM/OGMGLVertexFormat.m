//
//  OGMGLVertexFormat.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLVertexFormat.h"

@implementation OGMGLVertexFormat

-(id)initWithType:(const char *)type{
	self = [super init];
	if(self){
		_type = type;
		NSUInteger size = 0;
		NSUInteger align = 0;
		NSGetSizeAndAlignment(type,&size,&align);
		NSAssert(size==align, @"not support alignment");
		_stride = size;
	}
	return self;
}

@end
