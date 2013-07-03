//
//  OGMGLNode.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/19.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLNode.h"
#import "OGMErrorUtil.h"

@interface OGMGLNode(){
	BOOL _transformDirty;
	glm::mat4 _transform;
	BOOL _worldTransformDirty;
	glm::mat4 _worldTransform;
}
@property(nonatomic,strong)NSMutableArray * mutableChildren;

-(void)notifyTransformDirty;
-(void)notifyWorldTransformDirty;
@end

@implementation OGMGLNode

-(id)init{
	self = [super init];
	if(self){
		_mutableChildren = [NSMutableArray array];
		_elements = [NSMutableArray array];
		
		_pos = glm::vec3(0);
		_rot = glm::quat(0,glm::vec3(1,0,0));
		_scale = glm::vec3(1);
		
		_transformDirty = YES;
		_worldTransformDirty = YES;
	}
	return self;
}

-(id)initWithElement:(OGMGLElement *)element{
	self = [self init];
	if(self){
		[_elements addObject:element];
	}
	return self;
}

-(void)notifyTransformDirty{
	[self notifyWorldTransformDirty];
	_transformDirty = YES;
}

-(void)notifyWorldTransformDirty{
	for(OGMGLNode * child in _mutableChildren){
		if(!child->_worldTransformDirty)[child notifyWorldTransformDirty];
	}
	_worldTransformDirty = YES;
}

-(void)setParent:(OGMGLNode *)parent{
	if(_parent && parent)@throw OGMExceptionMake(NSGenericException,@"already has parent");
	_parent = parent;
	[self notifyWorldTransformDirty];
}

-(NSArray *)children{
	return _mutableChildren;
}
-(void)addChild:(OGMGLNode *)node{
	[self insertChild:node atIndex:_mutableChildren.count];
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
	[self notifyTransformDirty];
	_pos = pos;
}
-(void)setRot:(glm::quat)rot{
	[self notifyTransformDirty];
	_rot = rot;
}
-(void)setScale:(glm::vec3)scale{
	[self notifyTransformDirty];
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

-(void)renderWithRenderer:(OGMGLRenderer *)renderer{
	[renderer.modelView push];
	renderer.modelView.top = self.worldTransform;
	for(OGMGLElement * element in self.elements){
		[element renderWithRenderer:renderer];
	}
	[renderer.modelView pop];
}

@end
