//
//  OGMShader.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//
#pragma once

#import "OGMPPCppOnly.h"

#import "OGMCommon.h"
#import "OGMGLVertexBuffer.h"
#import "OGMGLIndexBuffer.h"

//こうでもしないとやってらんない
#define _SV(x) OGMGLStandardShaderVar_##x
typedef enum OGMGLStandardShaderVar{
	_SV(projection) = 0,
	_SV(modelView),
	_SV(pos),
	_SV(color),
	_SV(Max)
}OGMGLStandardShaderVar;
#undef _SV

@interface OGMGLStandardShader : NSObject

@property(nonatomic,assign)glm::mat4 projection;
@property(nonatomic,assign)glm::mat4 modelView;
@property(nonatomic,strong)OGMGLVertexBuffer * vertexBuffer;
@property(nonatomic,strong)OGMGLIndexBuffer * indexBuffer;

-(id)init;

-(GLint)locationOfVar:(int)var;


//描画直前に呼ぶ
-(void)prepare;

@end

