//
//  OGMShader.cpp
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#include "OGMStandardShader.h"

@interface OGMStandardShader(){
	GLuint _colorShader;
}
@end

@implementation OGMStandardShader
-(id)init{
	NSError * error = nil;
	self = [super init];
	if(self){
		{
			NSString * vsh = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"OGMStandardShaderColorShader" ofType:@"vsh"] encoding:NSUTF8StringEncoding error:&error];
			
		}
	}
	return self;
}
-(void)dealloc{

}
@end

