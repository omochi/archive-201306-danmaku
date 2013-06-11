//
//  OGMGLIndexBuffer.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/11.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLBuffer.h"

@interface OGMGLIndexBuffer : OGMGLBuffer

@property(nonatomic,assign)GLenum drawMode;

-(id)initWithDrawMode:(GLenum)drawMode usage:(GLenum)usage keepData:(BOOL)keepData;

-(void)setIndexList:(OGMTypeBuffer *)list;

@end
