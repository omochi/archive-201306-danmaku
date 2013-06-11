//
//  OGMGLBuffer.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMTypeBuffer.h"

@interface OGMGLBuffer : NSObject

@property(nonatomic,readonly)GLenum target;
@property(nonatomic,readonly)GLenum usage;
@property(nonatomic,readonly)uint32_t size;

//転送後にデータを保持し続けるかどうか
@property(nonatomic,assign)BOOL keepData;

-(id)initWithTarget:(GLenum)target type:(const char *)type
			  usage:(GLenum)usage keepData:(BOOL)keepData;

-(void)prepare;

-(OGMTypeBuffer *)buffer;

-(void)updateSize:(uint32_t)size;
//初回prepare前まで変化を許すかどうか
-(void)updateSize:(uint32_t)size initOnly:(BOOL)initOnly;

//初回のみ許す
-(void)updateUsage:(GLenum)usage;

@end
