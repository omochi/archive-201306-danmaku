//
//  OGMGLNode.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/19.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLNode.h"
#import "OGMErrorUtil.h"

@interface OGMGLNode()
@property(nonatomic,strong)NSMutableArray * mutableChildren;

@property(nonatomic,assign)BOOL transformDirty;
@property(nonatomic,assign)glm::mat4 transform;
@property(nonatomic,assign)BOOL worldTransformDirty;
@property(nonatomic,assign)glm::mat4 worldTransform;
@end

@implementation OGMGLNode

-(id)initWithElement:(OGMGLStandardElement *)element{
	self = [super init];
	if(self){
		_element = element;
		_mutableChildren = [NSMutableArray array];
		
		_pos = glm::vec3(0);
		_rot = glm::quat(0,glm::vec3(1,0,0));
		_scale = glm::vec3(1);
		
		_transformDirty = YES;
		_worldTransformDirty = YES;
	}
	return self;
}

-(void)setTransformDirty:(BOOL)transformDirty{
	if(transformDirty){
		self.worldTransformDirty = YES;
	}
	_transformDirty = transformDirty;
}

-(void)setWorldTransformDirty:(BOOL)worldTransformDirty{
	if(worldTransformDirty){
		for(OGMGLNode * child in _mutableChildren){
			if(!child.worldTransformDirty)child.worldTransformDirty = YES;
		}
	}
	_worldTransformDirty = worldTransformDirty;
}

-(void)setParent:(OGMGLNode *)parent{
	if(_parent && parent)@throw OGMExceptionMake(NSGenericException,@"already has parent");
	_parent = parent;
	self.worldTransformDirty = YES;
}

-(NSArray *)children{
	return _mutableChildren;
}
-(void)addChild:(OGMGLNode *)node{
	[self insertChild:node atIndex:_mutableChildren.count - 1];
}
-(void)insertChild:(OGMGLNode *)node atIndex:(uint32_t)index{
	node.parent = self;
	[_mutableChildren insertObject:node atIndex:index];
}
-(void)removeChild:(OGMGLNode *)node{
	self.parent = nil;
	[_mutableChildren removeObject:node];
}

-(void)setPos:(glm::vec3)pos{
	self.transformDirty = YES;
	_pos = pos;
}
-(void)setRot:(glm::quat)rot{
	self.transformDirty = YES;
	_rot = rot;
}
-(void)setScale:(glm::vec3)scale{
	self.transformDirty = YES;
	_scale = scale;
}

-(glm::mat4)transform{
	if(_transformDirty){
		_transformDirty = NO;
		_transform = glm::translate(_pos);
		_transform *= glm::mat4_cast(_rot);
		_transform *= glm::scale(_scale);
	}
	return _transform;
}

-(glm::mat4)worldTransform{
	if(_worldTransformDirty){
		_worldTransformDirty = NO;
		if(_parent){
			_worldTransform = [_parent worldTransform];
			_worldTransform *= [self transform];
		}else{
			_worldTransform = [self transform];
		}
	}
	return _worldTransform;
}

@end
