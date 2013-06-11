//
//  OGMGLElement.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/09.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLUtil.h"
#import "OGMGLStandardShader.h"

@interface OGMGLElement : NSObject

-(void)renderWithStandardShader:(OGMGLStandardShader *)shader;

@end
