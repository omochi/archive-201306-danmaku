//
//  OGMGLRenderer.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/16.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

#import "OGMGLMatrixStack.h"

@class OGMGLElement;

@interface OGMGLRenderer : NSObject

@property(nonatomic,readonly)OGMGLMatrixStack *projection;
@property(nonatomic,readonly)OGMGLMatrixStack *modelView;

//overrideしてElementのrenderWith<T>を呼ぶ
-(void)dispatchElementRender:(OGMGLElement *)element;

-(void)render;

@end
