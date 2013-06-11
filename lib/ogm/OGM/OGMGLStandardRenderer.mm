//
//  OGMShader.cpp
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLStandardRenderer.h"
#import "OGMErrorUtil.h"
#import "OGMGLUtil.h"
#import "OGMGLReleaser.h"

@interface OGMGLStandardRenderer(){
	GLuint _colorShader;
}
@property(nonatomic,strong)OGMGLReleaser * glReleaser;
@end

@implementation OGMGLStandardRenderer
-(id)init{
	self = [super init];
	if(self){
		_glReleaser = [[OGMGLReleaser alloc]init];
	}
	return self;
}
-(BOOL)prepareWithError:(NSError **)error{
	
	if(!_colorShader){
		NSString * vshPath = [[NSBundle mainBundle] pathForResource:@"OGMGLColorShader" ofType:@"vsh"];
		NSString * fshPath = [[NSBundle mainBundle] pathForResource:@"OGMGLColorShader" ofType:@"fsh"];
		_colorShader = OGMGLBuildProgramWithPaths(vshPath,fshPath, error);
		if(!_colorShader)return NO;
		
		[self.glReleaser addReleaser:^(OGMGLStandardRenderer *welf) {
			if(welf->_colorShader){
				glDeleteProgram(welf->_colorShader);
				OGMGLAssert(@"glDeleteProgram/colorShader");
			}
		} self:self];
	}
	
	return YES;
}
@end

