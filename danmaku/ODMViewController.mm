//
//  ODMViewController.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/03.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "ODMViewController.h"

#import <OGM/OGM.h>

@interface ODMViewController ()
@property(nonatomic,strong)EAGLContext *glContext;
@property(nonatomic,strong)OGMStandardShader * shader;
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
		@throw OGMExceptionMake(NSGenericException, @"glContext create failed");
    }
	[EAGLContext setCurrentContext:self.glContext];
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.glContext;
	view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
	view.drawableStencilFormat = GLKViewDrawableStencilFormatNone;
	view.drawableMultisample = GLKViewDrawableMultisampleNone;
	
	self.preferredFramesPerSecond = 60;
	
	self.shader = [[OGMStandardShader alloc]init];
}

-(void)update{
	
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
	glClearColor(0.0f, 0.0f, 0.1f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

@end
