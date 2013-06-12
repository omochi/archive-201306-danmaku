//
//  OGMShader.cpp
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLStandardShader.h"
#import "OGMTypeBuffer.h"
#import "OGMErrorUtil.h"
#import "OGMGLUtil.h"
#import "OGMGLReleaser.h"

#define _SV(x) OGMGLStandardShaderVar_##x

@interface OGMGLStandardShader()
@property(nonatomic,strong)OGMGLReleaser * glReleaser;

@property(nonatomic,assign)GLuint glProgId;

@property(nonatomic,strong)OGMTypeBuffer *glLocationTable;

-(void)setLocation:(GLint) location ofVar:(int)var;

@end

@implementation OGMGLStandardShader
-(id)init{
	self = [super init];
	if(self){
		_glReleaser = [[OGMGLReleaser alloc]init];
		
		_glLocationTable = [[OGMTypeBuffer alloc]initWithObjCType:@encode(GLint) size:_SV(Max)];
	}
	return self;
}
-(GLint)locationOfVar:(int)var{
	return static_cast<GLint*>(_glLocationTable.ptr)[var];
}

-(void)setLocation:(GLint) location ofVar:(int)var{
	static_cast<GLint*>(_glLocationTable.ptr)[var] = location;
}

-(void)prepare{
	NSError * error ;

	if(!_glProgId){
		NSString * vshPath = [[NSBundle mainBundle] pathForResource:@"OGMGLColorShader" ofType:@"vsh"];
		NSString * fshPath = [[NSBundle mainBundle] pathForResource:@"OGMGLColorShader" ofType:@"fsh"];
		_glProgId = OGMGLBuildProgramWithPaths(vshPath,fshPath,&error);
		if(!_glProgId)@throw OGMExceptionMakeWithError(error);
		
		[self.glReleaser addReleaser:^(OGMGLStandardShader *welf) {
			if(welf->_glProgId){
				glDeleteProgram(welf->_glProgId);
				OGMGLAssert(@"glDeleteProgram/colorShader");
			}
		} self:self];

#define _BIND_LU(x) {\
		[self setLocation:glGetUniformLocation(_glProgId,#x) ofVar:_SV(x)];\
		OGMGLAssert(@"glGetUniformLocation/" @#x);\
	}
#define _BIND_LV(x) {\
		[self setLocation:glGetAttribLocation(_glProgId,#x) ofVar:_SV(x)];\
		OGMGLAssert(@"glGetAttribLocation/" @#x);\
	}
		
		_BIND_LU(projection);
		_BIND_LU(modelView);
		_BIND_LV(pos);
		_BIND_LV(color);
	}
	
	glUseProgram(_glProgId);
	OGMGLAssert(@"glUseProgram");
	
	glUniformMatrix4fv([self locationOfVar:_SV(projection)],1,GL_FALSE,glm::value_ptr(_projection));
	OGMGLAssert(@"glUniformMatrix/projection");
	glUniformMatrix4fv([self locationOfVar:_SV(modelView)],1,GL_FALSE,glm::value_ptr(_modelView));
	OGMGLAssert(@"glUniformMatrix/modelView");
	
}
@end

