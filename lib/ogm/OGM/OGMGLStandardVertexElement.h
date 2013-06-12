//
//  OGMPrimitiveElement.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/09.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLElement.h"
#import "OGMGLStandardVertex.h"
#import "OGMGLVertexBuffer.h"
#import "OGMGLIndexBuffer.h"

@interface OGMGLStandardVertexElement : OGMGLElement

@property(nonatomic,strong)OGMGLVertexBuffer * vertices;
@property(nonatomic,strong)OGMGLIndexBuffer * indices;

//colorを単色塗り。keepDataでない場合はcolor以外の再構築が必要。
-(glm::vec4)color;
-(void)setColor:(glm::vec4)color;

@end

//GL_DYNAMIC_DRAW + keepDataで作られる。
OGMGLStandardVertexElement  * OGMGLQuadVertexElementMake(OGMGLStandardVertexFormat * format,CGRect quad);