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

#import "OGMGLVertexFormat.h"
#import "OGMGLVertexBuffer.h"
#import "OGMGLIndexBuffer.h"
#import "OGMGLTexture.h"



//こうでもしないとやってらんない
#define _SV(x) OGMGLStandardShaderVar_##x
typedef enum OGMGLStandardShaderVar{
	_SV(projection) = 0,
	_SV(modelView),
	_SV(pos),
	_SV(color),
	_SV(uv),
	_SV(texture),
	_SV(Max)
}OGMGLStandardShaderVar;
#undef _SV

@interface OGMGLStandardShader : OGMGLShader

@property(nonatomic,assign)glm::mat4 projection;
@property(nonatomic,assign)glm::mat4 modelView;
@property(nonatomic,strong)OGMGLVertexBuffer * vertexBuffer;
@property(nonatomic,strong)OGMGLIndexBuffer * indexBuffer;
@property(nonatomic,strong)OGMGLTexture * texture;

-(id)init;

-(void)render;

@end

@protocol OGMGLStandardShaderRenderable
-(void)renderWithStandardShader:(OGMGLStandardShader *)shader;
@end

