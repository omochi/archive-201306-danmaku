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
@property(nonatomic,readonly)GLenum usage;
@property(nonatomic,readonly)uint32_t size;

//転送後にデータを保持し続けるかどうか
@property(nonatomic,assign)BOOL keepData;

-(id)initWithType:(OGMGLVertexType)type usage:(GLenum)usage keepData:(BOOL)keepData;

-(void)prepare;

-(OGMTypeBuffer *)buffer;

-(void)updateSize:(uint32_t)size;
-(void)updateSize:(uint32_t)size initOnly:(BOOL)initOnly;

//転送済みの場合は全て再構築が必要
-(void)setPosList:(OGMTypeBuffer *)list;
-(void)setColorList:(OGMTypeBuffer *)list;
-(void)setUvList:(OGMTypeBuffer *)list;
-(void)setNormalList:(OGMTypeBuffer *)list;

@end
