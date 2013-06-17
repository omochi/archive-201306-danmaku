//
//  OGMGLMatrixStack.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/18.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

@interface OGMGLMatrixStack : NSObject
-(id)init;
-(glm::mat4 *)topPtr;

-(glm::mat4)top;
-(void)setTop:(glm::mat4)top;
-(void)push;
-(void)pop;
@end
