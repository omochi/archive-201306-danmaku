//
//  OGMMemoryUtil.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMMemoryUtil.h"

void * OGMMemoryByteOffset(void *ptr,uint32_t offset){
	return (uint8_t *)ptr + offset;
}