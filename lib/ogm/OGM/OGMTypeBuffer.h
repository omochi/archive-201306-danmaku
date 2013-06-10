//
//  OGMTypeBuffer.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//
#pragma once

#import "OGMCommon.h"

#ifdef __cplusplus
extern "C" {
#endif

#define _NS(name) OGM##name
	
#define OGM_TYPEBUFFER_PTR(type,tb) (type *)([(tb) ptrWithTypeAssert:@encode(type)])

@interface _NS(TypeBuffer) : NSObject

-(id)initWithObjCType:(const char *)type;
-(id)initWithObjCType:(const char *)type size:(uint32_t)size;

-(const char *)objCType;
-(size_t)typeSize;
@property(nonatomic,assign)uint32_t size;
-(uint32_t)allocSize;
-(void *)ptr;
-(void *)ptrAt:(uint32_t)index;

-(void *)ptrWithTypeAssert:(const char *)objCType;

-(void)reserve:(uint32_t)size;

-(void)spliceAt:(uint32_t)index len:(uint32_t)len items:(void *)items itemsNum:(uint32_t)itemsNum;
-(void)removeAt:(uint32_t)index len:(uint32_t)len;
-(void)removeAt:(uint32_t)index;
-(void)insertAt:(uint32_t)index items:(void *)items itemsNum:(uint32_t)itemsNum;
-(void)insertAt:(uint32_t)index item:(void *)item;
-(void)add:(void *)item;

@end

#undef _NS
	
#ifdef __cplusplus
}
#endif