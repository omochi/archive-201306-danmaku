//
//  OGMGLVertexFormat.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

@interface OGMGLVertexFormat : NSObject

@property(nonatomic,readonly)const char * type;
@property(nonatomic,readonly)uint32_t stride;

-(id)initWithType:(const char *)type;

@end
