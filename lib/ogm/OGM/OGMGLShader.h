//
//  OGMGLShader.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

@class OGMGLElement;

@interface OGMGLShader : NSObject

-(id)initWithLocationNum:(uint32_t)locationNum;
-(GLint)locationOfVar:(int)var;

//overrideしてElementのrenderWith<T>を呼ぶ
-(void)dispatchElementRender:(OGMGLElement *)element;

-(void)render;


@end
