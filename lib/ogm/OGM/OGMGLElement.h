//
//  OGMGLElement.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/09.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLUtil.h"

#import "OGMGLShader.h"
#import "OGMGLRenderer.h"
#import "OGMGLMatrixStack.h"

@interface OGMGLElement : NSObject

@property(nonatomic,readonly)OGMGLMatrixStack * transform;

-(void)renderWithShader:(OGMGLShader *)shader;

@end
