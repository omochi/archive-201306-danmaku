//
//  OGMGLStandardRenderer.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/16.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLRenderer.h"

#import "OGMGLVertexBuffer.h"
#import "OGMGLIndexBuffer.h"
#import "OGMGLTexture.h"

#import "OGMGLStandardVertex.h"

@class OGMGLStandardRenderer;

@protocol OGMGLStandardRenderable
-(void)renderWithStandardRenderer:(OGMGLStandardRenderer *)renderer;
@end

@interface OGMGLStandardRenderer : OGMGLRenderer

@property(nonatomic,assign)glm::mat4 projection;
@property(nonatomic,assign)glm::mat4 modelView;
@property(nonatomic,strong)OGMGLVertexBuffer * vertices;
@property(nonatomic,strong)OGMGLIndexBuffer * indices;
@property(nonatomic,strong)OGMGLTexture * texture;

@end

