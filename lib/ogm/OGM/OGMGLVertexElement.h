//
//  OGMPrimitiveElement.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/09.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLElement.h"
#import "OGMGLVertexBuffer.h"
#import "OGMGLIndexBuffer.h"

@interface OGMGLVertexElement : OGMGLElement

@property(nonatomic,strong)OGMGLVertexBuffer * vertices;
@property(nonatomic,strong)OGMGLIndexBuffer * indices;

//単色塗り
-(glm::vec4)color;
-(void)setColor:(glm::vec4)color;

@end

//prepare前にtransfer=NOで転送防止可能
OGMGLVertexElement  * OGMGLQuadVertexElementMake(OGMGLVertexType type,CGRect quad);