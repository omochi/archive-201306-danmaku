//
//  OGMGLColorShader.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/16.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

// シェーダーの切替テストのため、わざわざ単純カラーシェーダーを分離する

#import "OGMGLShader.h"

#define _SV(x) OGMGLColorShaderVar_##x
typedef enum OGMGLColorShaderVar{
	_SV(projection) = 0,
	_SV(modelView),
	_SV(pos),
	_SV(color),
	_SV(Max)
}OGMGLColorShaderVar;
#undef _SV

@interface OGMGLColorShader : OGMGLShader

-(id)init;

@end
