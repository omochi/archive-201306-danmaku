//
//  OGMGLCameraNode.h
//  Danmaku
//
//  Created by おもちメタル on 2013/07/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLNode.h"

@interface OGMGLCameraNode : OGMGLNode

@property(nonatomic,assign)glm::mat4 projection;

-(id)initWithProjection:(glm::mat4)projection;

-(glm::mat4)projectionTransform;

@end
