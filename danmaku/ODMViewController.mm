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
@property(nonatomic,strong)OGMGLStandardShader * shader;
@property(nonatomic,strong)OGMGLStandardElement * quadElement;
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
	
	self.shader = [[OGMGLStandardShader alloc]init];
	self.quadElement = OGMGLQuadElementMake([OGMGLStandardVertexFormat formatPCT],CGRectMake(0.1, 0.1, 0.8, 0.8));
	
	OGMGLVertexBufferSetColorList(self.quadElement.vertices,
								  OGM_TYPEBUFFER_MAKE(glm::vec4,
													  glm::vec4(1,1,1,1),
													  glm::vec4(1,1,1,1),
													  glm::vec4(1,1,1,1),
													  glm::vec4(1,1,1,1))
								  );
	OGMGLQuadElementUpdateTexture(self.quadElement,
								  [OGMGLTexture textureWithUIImage:[UIImage imageNamed:@"redbull-miku"]]);
	
	
}

-(void)update{
	
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
	glClearColor(0.0f, 0.0f, 0.1f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	self.shader.projection = glm::mat4(1);
	self.shader.modelView = glm::mat4(1);
	
	[self.quadElement renderWithStandardShader:self.shader];
	
}

@end
