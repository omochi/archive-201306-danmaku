//
//  OGMPrimitiveElement.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/09.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLVertexElement.h"

@implementation OGMGLVertexElement{
	glm::vec4 _color;
}

-(glm::vec4)color{
	return _color;
}
-(void)setColor:(glm::vec4)color{
	OGMTypeBuffer * colorList = [[OGMTypeBuffer alloc]initWithObjCType:@encode(glm::vec4)
																  size:self.vertices.buffer.size];
	glm::vec4 * d = OGM_TYPEBUFFER_PTR(glm::vec4, colorList);
	for(int i=0;i<colorList.size;i++,d++){
		*d = color;
	}
	[self.vertices setColorList:colorList];
	
	_color = color;
}


-(void)renderByStandardRenderer:(OGMGLStandardRenderer *)renderer{
}


@end

// 左上、左下、右下、右上
OGMGLVertexElement  * OGMGLQuadVertexElementMake(OGMGLVertexType type,CGRect quad){
	OGMGLVertexBuffer * vertices = [[OGMGLVertexBuffer alloc]initWithVertexType:type usage:GL_DYNAMIC_DRAW keepData:YES];
	
	OGMTypeBuffer * posList = [[OGMTypeBuffer alloc]initWithObjCType:@encode(glm::vec3) size:4];
	glm::vec3 * pos = OGM_TYPEBUFFER_PTR(glm::vec3, posList);
	pos[0] = glm::vec3(CGRectGetMinX(quad),CGRectGetMaxY(quad),0);
	pos[1] = glm::vec3(CGRectGetMinX(quad),CGRectGetMinY(quad),0);
	pos[2] = glm::vec3(CGRectGetMaxX(quad),CGRectGetMinY(quad),0);
	pos[3] = glm::vec3(CGRectGetMaxX(quad),CGRectGetMaxY(quad),0);
	[vertices setPosList:posList];
	
	if(OGMGLVertexTypeHasNormal(type)){
		OGMTypeBuffer * normalList = [[OGMTypeBuffer alloc]initWithObjCType:@encode(glm::vec3) size:4];
		glm::vec3 * normal = OGM_TYPEBUFFER_PTR(glm::vec3, normalList);
		for(int i=0;i<4;i++)normal[i] = glm::vec3(0,0,1);
		[vertices setNormalList:normalList];
	}
	
	OGMGLIndexBuffer * indices = [[OGMGLIndexBuffer alloc]initWithDrawMode:GL_TRIANGLE_STRIP usage:GL_DYNAMIC_DRAW keepData:YES];

	OGMTypeBuffer * indexList = [[OGMTypeBuffer alloc]initWithObjCType:@encode(uint16_t) size:4];
	uint16_t * index = OGM_TYPEBUFFER_PTR(uint16_t,indexList);
	index[0] = 0;
	index[1] = 1;
	index[2] = 3;
	index[3] = 2;
	[indices setIndexList:indexList];
	
	OGMGLVertexElement * element = [[OGMGLVertexElement alloc]init];
	element.vertices = vertices;
	element.indices = indices;
	
	[element setColor:glm::vec4(1,1,1,1)];
	return element;
}

