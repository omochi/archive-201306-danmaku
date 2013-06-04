//
//  OGMShader.cpp
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMStandardShader.h"
#import "OGMErrorUtil.h"
#import "OGMGLUtil.h"

@interface OGMStandardShader(){
	GLuint _colorShader;
}
@end

@implementation OGMStandardShader
-(id)init{
	NSError * error = nil;
	self = [super init];
	if(self){
		{
			NSString * vshSrc = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"OGMStandardShaderColorShader" ofType:@"vsh"] encoding:NSUTF8StringEncoding error:&error];
			if(!vshSrc)@throw OGMExceptionMakeWithError(error);
			
			GLuint vsh = OGMGLCompileShader(GL_VERTEX_SHADER, vshSrc);
#warning TODO: シェーダー構築の続き
		}
	}
	return self;
}
-(void)dealloc{

}
@end

