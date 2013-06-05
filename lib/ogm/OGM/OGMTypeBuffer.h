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

@interface _NS(TypeBuffer) : NSObject

-(id)initWithTypeSize:(size_t)typeSize;
-(id)initWithTypeSize:(size_t)typeSize size:(uint32_t)size;

-(size_t)typeSize;
-(uint32_t)size;
-(uint32_t)allocSize;
-(void *)ptr;
-(void *)ptrAtIndex:(uint32_t)index;

@end

#undef _NS
	
#ifdef __cplusplus
}
#endif