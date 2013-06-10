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

OGMGLVertexElement  * OGMGLQuadVertexElementMake(OGMGLVertexType type,CGRect quad){
	OGMGLVertexBuffer * vertices = [[OGMGLVertexBuffer alloc]initWithType:type transfer:YES];
	vertices.buffer.size = 4;
	
	
}