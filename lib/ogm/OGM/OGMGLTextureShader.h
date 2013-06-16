//
//  OGMGLTextureShader.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/17.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

// テクスチャ+頂点カラーのシェーダー

#import "OGMGLShader.h"

extern NSString * const OGMGLTextureVertexShaderSource;
extern NSString * const OGMGLTextureFragmentShaderSource;

#define _SV(x) OGMGLTextureShaderVar_##x
typedef enum OGMGLTextureShaderVar{
	_SV(projection) = 0,
	_SV(modelView),
	_SV(texture),
	_SV(pos),
	_SV(color),
	_SV(uv),
	_SV(Max)
}OGMGLTextureShaderVar;
#undef _SV

@interface OGMGLTextureShader : OGMGLShader

-(id)init;

@end
