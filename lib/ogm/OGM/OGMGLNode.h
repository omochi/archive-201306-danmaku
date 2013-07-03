//
//  OGMGLNode.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/19.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLStandardElement.h"

@interface OGMGLNode : NSObject

@property(nonatomic,readonly)NSMutableArray * elements;

@property(nonatomic,weak,readonly)OGMGLNode * parent;

@property(nonatomic,assign)glm::vec3 pos;
@property(nonatomic,assign)glm::quat rot;
@property(nonatomic,assign)glm::vec3 scale;

-(id)init;
-(id)initWithElement:(OGMGLElement *)element;

-(NSArray *)children;
-(void)addChild:(OGMGLNode *)node;
-(void)insertChild:(OGMGLNode *)node atIndex:(uint32_t)index;
-(void)removeChild:(OGMGLNode *)node;

//親座標系でのローカル変換
-(glm::mat4)transform;

//ルートノードからの変換
-(glm::mat4)worldTransform;


-(void)renderWithRenderer:(OGMGLRenderer *)renderer;

@end
