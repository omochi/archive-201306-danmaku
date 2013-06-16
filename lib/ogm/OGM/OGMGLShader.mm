//
//  OGMGLShader.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLShader+Protected.h"
#import "OGMObjCUtil.h"
#import "OGMErrorUtil.h"

@implementation OGMGLShader

-(id)initWithVertexShader:(NSString *)vertexShader
		   fragmentShader:(NSString *)fragmentShader
			  locationNum:(uint32_t)locationNum{
	self = [super init];
	if(self){
		OGMAbstractClassNotAllocCheck(self,[OGMGLShader class]);
		
		_glReleaser = [[OGMGLReleaser alloc]init];
		_glLocationTable = [[OGMTypeBuffer alloc]initWithObjCType:@encode(GLint) size:locationNum];
		
		_vertexShader = vertexShader;
		_fragmentShader = fragmentShader;
	}
	return self;
}

-(id)initWithVertexShaderPath:(NSString *)vertexShaderPath fragmentShaderPath:(NSString *)fragmentShaderPath locationNum:(uint32_t)locationNum{
	NSError * error;
	NSString * vsh = [NSString stringWithContentsOfFile:vertexShaderPath encoding:NSUTF8StringEncoding error:&error];
	if(!error)@throw OGMExceptionMakeWithError(error);
	NSString * fsh = [NSString stringWithContentsOfFile:fragmentShaderPath encoding:NSUTF8StringEncoding error:&error];
	if(!error)@throw OGMExceptionMakeWithError(error);
	return [self initWithVertexShader:vsh fragmentShader:fsh locationNum:locationNum];
}

-(id)initWithShaderName:(NSString *)name locationNum:(uint32_t)locationNum{
	return [self initWithVertexShaderPath:[[NSBundle mainBundle]pathForResource:name ofType:@"vsh"]
					   fragmentShaderPath:[[NSBundle mainBundle]pathForResource:name ofType:@"fsh"]
							  locationNum:locationNum];
}


-(GLint)locationOfVar:(int)var{
	return static_cast<GLint*>(_glLocationTable.ptr)[var];
}

-(void)setLocation:(GLint) location ofVar:(int)var{
	static_cast<GLint*>(_glLocationTable.ptr)[var] = location;
}

-(void)bindUniform:(const char *)name ofVar:(int)var{
	[self setLocation:OGMGLGetUniformLocation(_glProgId, name) ofVar:var];
}
-(void)bindAttribute:(const char *)name ofVar:(int)var{
	[self setLocation:OGMGLGetAttribLocation(_glProgId, name) ofVar:var];
}

-(void)dispatchElementRender:(OGMGLElement *)element{
	@throw OGMExceptionMake(NSGenericException,@"can't render this element");
}


-(void)prepare{

	
	if(!_glProgId){
		NSError * error ;
		_glProgId = OGMGLBuildProgram(self.vertexShader,self.fragmentShader,&error);
		if(!_glProgId)@throw OGMExceptionMakeWithError(error);
		
		self.vertexShader = nil;
		self.fragmentShader = nil;
		
		[self.glReleaser addReleaser:^(OGMGLShader *welf) {
			if(welf->_glProgId){
				glDeleteProgram(welf->_glProgId);
				OGMGLAssert(@"glDeleteProgram");
			}
		} self:self];
		
		[self onBuild];
	}
	
	glUseProgram(_glProgId);
	OGMGLAssert(@"glUseProgram");
}
-(void)render{
	
}

-(void)onBuild{}

@end
