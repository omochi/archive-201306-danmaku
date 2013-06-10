//
//  OGMGLIndexBuffer.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/11.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMTypeBuffer.h"

@interface OGMGLIndexBuffer : NSObject

@property(nonatomic,assign)GLenum drawMode;
@property(nonatomic,readonly)OGMTypeBuffer *buffer;

-(id)initWithDrawMode:(GLenum)drawMode transfer:(BOOL)transfer;
-(BOOL)prepare;

@end
