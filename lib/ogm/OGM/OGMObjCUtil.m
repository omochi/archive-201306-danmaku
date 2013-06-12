//
//  OGMObjCUtil.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMObjCUtil.h"
#import "OGMErrorUtil.h"

void OGMAbstractClassNotAllocCheck(id self,Class aClass){
	if([self isMemberOfClass:aClass]){
		@throw OGMExceptionMake(NSGenericException, @"%@ is abstract class but alloced",NSStringFromClass(aClass));
	}
}
