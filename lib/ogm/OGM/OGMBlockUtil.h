//
//  OGMBlockUtil.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

OGM_EXTERN_C_BEGIN

typedef void (^OGMWeakSelfBlock)(id welf);

//selfをweakでキャプチャしてヒープにのったブロックを返す
dispatch_block_t OGMWeakSelfBlockBindSelf(OGMWeakSelfBlock wsblock,id aSelf);

OGM_EXTERN_C_END