//
//  OGMGLVertexFormat.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLVertexFormat.h"
#import "OGMObjCUtil.h"

@implementation OGMGLVertexFormat

-(id)initWithType:(const char *)type{
	self = [super init];
	if(self){
		_type = type;
		_stride = OGMObjCTypeSize(_type);
	}
	return self;
}

@end
