//
//  OGMShader.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//
#pragma once

#import "OGMPPCppOnly.h"

#import "OGMGLShader.h"

#import "OGMCommon.h"
#import "OGMGLStandardVertex.h"
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


@interface OGMGLStandardShader : OGMGLShader

@property(nonatomic,assign)glm::mat4 projection;
@property(nonatomic,assign)glm::mat4 modelView;
@property(nonatomic,strong)OGMGLVertexBuffer * vertexBuffer;
@property(nonatomic,strong)OGMGLIndexBuffer * indexBuffer;

-(id)init;

@end

@protocol OGMGLStandardShaderRenderable
-(void)renderWithStandardShader:(OGMGLStandardShader *)shader;
@end

