//
//  OGMGLVertexBuffer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLVertexBuffer.h"

#import "OGMGLReleaser.h"

@interface OGMGLVertexBuffer()
@property(nonatomic,assign)BOOL transfer;
@property(nonatomic,strong)OGMGLReleaser * glReleaser;
@end

@implementation OGMGLVertexBuffer

-(id)initWithType:(OGMGLVertexType)type transfer:(BOOL)transfer{
	self = [super init];
	if(self){
		_type = type;
		_buffer = [[OGMTypeBuffer alloc]initWithTypeSize:OGMGLVertexTypeSize(type)];
		
		_transfer = transfer;
		_glReleaser = [[OGMGLReleaser alloc]init];
	}
	return self;
}

-(BOOL)prepare{
	if(_transfer){
		if(_buffer){
#warning todo: transfer
			_buffer = nil;
		}
	}
}

@end
