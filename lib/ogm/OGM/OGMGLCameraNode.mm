//
//  OGMGLCameraNode.m
//  Danmaku
//
//  Created by おもちメタル on 2013/07/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLCameraNode.h"

#import "OGMMathUtil.h"

@implementation OGMGLCameraNode

-(id)initWithProjection:(glm::mat4)projection{
	self = [super init];
	if(self){
		_projection = projection;
	}
	return self;
}

-(glm::mat4)projectionTransform{
	glm::mat4 viewing = OGMMathMatrix4ToViewing(self.worldTransform);
	return self.projection * OGMMathViewingMatrixInvert(viewing);
//	return self.projection;
}

@end
