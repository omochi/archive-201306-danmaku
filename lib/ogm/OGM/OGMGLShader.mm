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

-(id)initWithLocationNum:(uint32_t)locationNum{
	self = [super init];
	if(self){
		OGMAbstractClassNotAllocCheck(self,[OGMGLShader class]);
		
		_glReleaser = [[OGMGLReleaser alloc]init];
		_glLocationTable = [[OGMTypeBuffer alloc]initWithObjCType:@encode(GLint) size:locationNum];
	}
	return self;
}

-(GLint)locationOfVar:(int)var{
	return static_cast<GLint*>(_glLocationTable.ptr)[var];
}

-(void)setLocation:(GLint) location ofVar:(int)var{
	static_cast<GLint*>(_glLocationTable.ptr)[var] = location;
}
-(void)dispatchElementRender:(OGMGLElement *)element{
	@throw OGMExceptionMake(NSGenericException,@"can't render this element");
}
-(void)prepare{
	
}

-(void)clear{
	
}



@end
