//
//  OGMGLRenderer.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/16.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

@class OGMGLElement;

@interface OGMGLRenderer : NSObject

//overrideしてElementのrenderWith<T>を呼ぶ
-(void)dispatchElementRender:(OGMGLElement *)element;

-(void)render;

@end
