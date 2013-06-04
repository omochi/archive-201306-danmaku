//
//  OGMShader.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

@interface OGMShader : NSObject

-(id)initWithVertexShaderPath:(NSString *)vertexShaderPath
	fragmentShaderPath:(NSString *)fragmentShaderPath;

@end

