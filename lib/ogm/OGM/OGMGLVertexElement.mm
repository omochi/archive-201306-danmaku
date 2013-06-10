//
//  OGMPrimitiveElement.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/09.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLVertexElement.h"

@implementation OGMGLVertexElement

-(void)renderByStandardRenderer:(OGMGLStandardRenderer *)renderer{
}


@end

// 左上、左下、右下、右上
OGMGLVertexElement  * OGMGLQuadVertexElementMake(OGMGLVertexType type,CGRect quad){
	OGMGLVertexBuffer * vertices = [[OGMGLVertexBuffer alloc]initWithType:type transfer:YES];
	vertices.buffer.size = 4;
	
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
	
	OGMGLIndexBuffer * indices = [[OGMGLIndexBuffer alloc]initWithDrawMode:GL_TRIANGLE_STRIP transfer:YES];
	indices.buffer.size = 4;
	uint16_t * index = OGM_TYPEBUFFER_PTR(uint16_t,indices);
	index[0] = 0;
	index[1] = 1;
	index[2] = 3;
	index[3] = 2;
	
	OGMGLVertexElement * element = [[OGMGLVertexElement alloc]init];
	element.vertices = vertices;
	element.indices = indices;
	return element;
}

