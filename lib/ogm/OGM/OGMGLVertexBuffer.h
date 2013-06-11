//
//  OGMGLVertexBuffer.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLBuffer.h"

#import "OGMGLVertex.h"

@interface OGMGLVertexBuffer : OGMGLBuffer

@property(nonatomic,readonly)OGMGLVertexType vertexType;

-(id)initWithVertexType:(OGMGLVertexType)vertexType usage:(GLenum)usage keepData:(BOOL)keepData;

//転送済みの場合は全て再構築が必要
//型に存在しない属性を転送すると例外
-(void)setPosList:(OGMTypeBuffer *)list;
-(void)setColorList:(OGMTypeBuffer *)list;
-(void)setUvList:(OGMTypeBuffer *)list;
-(void)setNormalList:(OGMTypeBuffer *)list;

@end
