//
//  OGMGLTransform.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/17.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLTransform.h"

@interface OGMGLTransform()
@property(nonatomic,assign)BOOL dirty;
@property(nonatomic,assign)glm::mat4 transform;
@end

@implementation OGMGLTransform
-(id)init{
	self = [super init];
	if(self){
		[self setPos:glm::vec3(0)];
		[self setRot:glm::quat(0,glm::vec3(0))];
		[self setScale:glm::vec3(1)];
	}
	return self;
}
-(void)setPos:(glm::vec3)pos{
	_pos = pos;
	_dirty = YES;
}
-(void)setRot:(glm::quat)rot{
	_rot = rot;
	_dirty = YES;
}
-(void)setScale:(glm::vec3)scale{
	_scale = scale;
	_dirty = YES;
}
-(glm::mat4)transform{
	if(_dirty){
		_dirty = NO;
		glm::mat4 mtx(1);
		mtx *= glm::translate(_pos);
		mtx *= glm::mat4_cast(_rot);
		mtx *= glm::scale(_scale);
	}
	return _transform;
}
@end
