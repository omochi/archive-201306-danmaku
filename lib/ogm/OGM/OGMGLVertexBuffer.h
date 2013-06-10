//
//  OGMGLVertexBuffer.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLVertex.h"

#import "OGMTypeBuffer.h"

@interface OGMGLVertexBuffer : NSObject

@property(nonatomic,readonly)OGMGLVertexType type;
@property(nonatomic,readonly)OGMTypeBuffer *buffer;

-(id)initWithType:(OGMGLVertexType)type transfer:(BOOL)transfer;
-(BOOL)prepare;

//転送後の変更不可
-(void)setPosList:(OGMTypeBuffer *)list;
-(void)setColorList:(OGMTypeBuffer *)list;
-(void)setUvList:(OGMTypeBuffer *)list;
-(void)setNormalList:(OGMTypeBuffer *)list;

@end
