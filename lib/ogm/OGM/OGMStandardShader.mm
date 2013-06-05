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
	NSError * error;
	self = [super init];
	if(self){
		if(!^BOOL (NSError **error){
			NSString * vshPath = [[NSBundle mainBundle] pathForResource:@"OGMStandardShaderColorShader" ofType:@"vsh"];
			NSString * fshPath = [[NSBundle mainBundle] pathForResource:@"OGMStandardShaderColorShader" ofType:@"fsh"];
			_colorShader = OGMGLBuildProgramWithPaths(vshPath,fshPath, error);
			if(!_colorShader)return NO;
			
			return YES;
		}(&error)){
			@throw OGMExceptionMakeWithError(error);
		}
		
	}
	return self;
}
-(void)dealloc{

}
@end

