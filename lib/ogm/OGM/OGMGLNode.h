//
//  OGMGLNode.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/19.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLStandardElement.h"

@interface OGMGLNode : NSObject

@property(nonatomic,readonly)OGMGLStandardElement * element;

@property(nonatomic,readonly)OGMGLNode * parent;

@property(nonatomic,assign)glm::vec3 pos;
@property(nonatomic,assign)glm::quat rot;
@property(nonatomic,assign)glm::vec3 scale;

-(id)initWithElement:(OGMGLStandardElement *)element;

-(NSArray *)children;
-(void)addChild:(OGMGLNode *)node;
-(void)insertChild:(OGMGLNode *)node atIndex:(uint32_t)index;
-(void)removeChild:(OGMGLNode *)node;

-(glm::mat4)transform;

-(glm::mat4)worldTransform;

@end
