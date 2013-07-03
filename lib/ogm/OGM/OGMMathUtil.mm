//
//  OGMMathUtil.m
//  Danmaku
//
//  Created by おもちメタル on 2013/07/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMMathUtil.h"

glm::mat4 OGMMathMatrix4ToViewing(glm::mat4 m){
	glm::vec3 translation = glm::vec3(glm::column(m,3));
	glm::quat rotation = glm::normalize(glm::quat_cast(m));
	return glm::translate(translation) * glm::mat4_cast(rotation);
}

glm::mat4 OGMMathViewingMatrixInvert(glm::mat4 m){
	glm::vec3 translation = glm::vec3(glm::column(m,3));
	glm::mat3 rotation = glm::mat3(m);
	return glm::translate(-translation) * glm::mat4(glm::transpose(rotation));
}