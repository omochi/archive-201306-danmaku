//
//  OGMGLStandardRenderer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/16.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLStandardRenderer.h"

#import "OGMGLElement.h"

@implementation OGMGLStandardRenderer

-(void)dispatchElementRender:(OGMGLElement *)element{
	if([element conformsToProtocol:@protocol(OGMGLStandardRenderable)]){
		[(id)element renderWithStandardRenderer:self];
	}
}

-(void)render{
	
}

@end
