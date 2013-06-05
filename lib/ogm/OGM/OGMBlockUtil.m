//
//  OGMBlockUtil.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMBlockUtil.h"

dispatch_block_t OGMWeakSelfBlockBindSelf(OGMWeakSelfBlock wsblock,id aSelf){
	__weak id welf = aSelf;
	return [^(){
		wsblock(welf);
	} copy];
}