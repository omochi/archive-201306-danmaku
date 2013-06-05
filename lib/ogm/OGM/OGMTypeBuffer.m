//
//  OGMTypeBuffer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMTypeBuffer.h"

#import "OGMErrorUtil.h"

#define _NS(name) OGM##name

static inline uint8_t * u8p(void *p){ return (uint8_t *)p; }
static inline void * ptrAt(void *p,size_t tsz,uint32_t idx){ return u8p(p) + tsz*idx; }

@interface _NS(TypeBuffer)()

@property(nonatomic,assign)size_t typeSize;
@property(nonatomic,assign)uint32_t size;
@property(nonatomic,assign)uint32_t allocSize;
@property(nonatomic,assign)void * ptr;

-(void)assertIndex:(uint32_t)index;
-(void)reserve:(uint32_t)size;

@end

@implementation _NS(TypeBuffer)

-(id)initWithTypeSize:(size_t)typeSize{
	self = [super init];
	if(self){
		_typeSize = typeSize;
	}
	return self;
}

-(id)initWithTypeSize:(size_t)typeSize size:(uint32_t)size{
	self = [self initWithTypeSize:typeSize];
	if(self){
		self.size = size;
	}
	return self;
}

- (void)dealloc
{
	self.allocSize = 0;
}

-(void)setAllocSize:(uint32_t)allocSize{
	if(_allocSize == allocSize)return;
	if(allocSize == 0){
		free(_ptr);
		_ptr = NULL;
	}else{
		_ptr = realloc(_ptr, _typeSize * allocSize);
		if(_allocSize < allocSize){
			memset(ptrAt(_ptr, _typeSize, _allocSize), 0, _typeSize * (allocSize-_allocSize));
		}
	}
	_allocSize = allocSize;
}
-(void)setSize:(uint32_t)size{
	if(size > _allocSize){
		self.allocSize = size;
	}
	_size = size;
}

-(void)reserve:(uint32_t)size{
	if(_allocSize < size){
		if(_allocSize * 2 >= size){
			self.allocSize = _allocSize * 2;
		}else{
			self.allocSize = size;
		}
	}
}

-(void)assertIndex:(uint32_t)index{
	if(index >= self.size)@throw OGMExceptionMake(NSRangeException,@"out of range: index=%d,size=%d",index,self.size);
}

-(void *)ptrAtIndex:(uint32_t)index{
	[self assertIndex:index];
	return ptrAt(_ptr,_typeSize,index);
}

@end


#undef _NS

