//
//  OGMGLMatrixStack.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/18.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLMatrixStack.h"
#import "OGMTypeBuffer.h"
#import "OGMErrorUtil.h"
@interface OGMGLMatrixStack()
@property(nonatomic,strong)OGMTypeBuffer * matrices;
@end

@implementation OGMGLMatrixStack
-(id)init{
	self = [super init];
	if(self){
		_matrices = [[OGMTypeBuffer alloc]initWithObjCType:@encode(glm::mat4)];
		glm::mat4 m(1);
		[_matrices add:&m];
	}
	return self;
}
-(glm::mat4 *)topPtr{
	return (glm::mat4 *)[_matrices ptrAt:_matrices.size-1];
}

-(glm::mat4)top{
	return *[self topPtr];
}
-(void)setTop:(glm::mat4)top{
	*[self topPtr] = top;
}
-(void)push{
	glm::mat4 m = [self top];
	[_matrices add:&m];
}
-(void)pop{
	if(_matrices.size<=1)@throw OGMExceptionMake(NSGenericException,@"stack size: %d",_matrices.size);
	[_matrices removeAt:_matrices.size-1];
}
@end
