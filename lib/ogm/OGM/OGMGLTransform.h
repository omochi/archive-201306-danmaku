//
//  OGMGLTransform.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/17.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMPPCppOnly.h"
#import "OGMCommon.h"

@interface OGMGLTransform : NSObject
@property(nonatomic,assign)glm::vec3 pos;
@property(nonatomic,assign)glm::quat rot;
@property(nonatomic,assign)glm::vec3 scale;
-(glm::mat4)transform;
@end
