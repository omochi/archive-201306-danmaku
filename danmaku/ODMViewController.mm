//
//  ODMViewController.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/03.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "ODMViewController.h"



@interface ODMViewController ()
@property(nonatomic,strong)EAGLContext *glContext;
@end

@implementation ODMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	glm::mat4 test = glm::mat4(1);
	std::string str = glm::to_string(test);
	NSLog(@"%s",str.c_str());

	self.glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!self.glContext) {
		[NSException raise:NSGenericException format:@"glcontext create failed"];
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.glContext;
	view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
	view.drawableStencilFormat = GLKViewDrawableStencilFormatNone;
	view.drawableMultisample = GLKViewDrawableMultisampleNone;
	
	self.preferredFramesPerSecond = 60;
}

-(void)update{
	
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
	glClearColor(0.0f, 0.0f, 0.1f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

@end
