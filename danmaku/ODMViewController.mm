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
@property(nonatomic,strong)OGMGLStandardRenderer * renderer;


@property(nonatomic,strong)OGMGLNode * worldNode;
@property(nonatomic,strong)OGMGLCameraNode * camera2d;
@property(nonatomic,strong)OGMGLNode * colorTextureQuad;
@property(nonatomic,strong)OGMGLNode * colorQuad;
@property(nonatomic,strong)OGMGLNode * textureQuad;


@end

@implementation ODMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

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
	
	self.renderer = [[OGMGLStandardRenderer alloc]init];
	
	OGMGLTexture * mikuTexture = [OGMGLTexture textureWithUIImage:[UIImage imageNamed:@"redbull-miku"]];

	self.worldNode = [[OGMGLNode alloc]init];
	
	{
		self.camera2d = [[OGMGLCameraNode alloc]init];
		self.camera2d.pos = glm::vec3(0,0,10);
		[self.worldNode addChild:self.camera2d];
	}
	
	{
		OGMGLStandardElement * elem  = OGMGLQuadElementMake([OGMGLStandardVertexFormat formatPCT]);
		OGMGLVertexBufferSetColorList(elem.vertices,
									  OGM_TYPEBUFFER_MAKE(glm::vec4,
														  glm::vec4(1,0,0,1),
														  glm::vec4(1,1,0,1),
														  glm::vec4(0,1,0,1),
														  glm::vec4(0,0,1,1))
									  );
		OGMGLQuadElementUpdateTexture(elem,mikuTexture);
		
		self.colorTextureQuad = [[OGMGLNode alloc]initWithElement:elem];
		self.colorTextureQuad.scale = glm::vec3(100);
		[self.worldNode addChild:self.colorTextureQuad];
	}
	
	{
		OGMGLStandardElement * elem = OGMGLQuadElementMake([OGMGLStandardVertexFormat formatPC]);
		OGMGLVertexBufferSetColorList(elem.vertices,
									  OGM_TYPEBUFFER_MAKE(glm::vec4,
														  glm::vec4(1,0,0,1),
														  glm::vec4(1,1,0,1),
														  glm::vec4(0,1,0,1),
														  glm::vec4(0,0,1,1))
									  );
	
		self.colorQuad = [[OGMGLNode alloc]initWithElement:elem];
		self.colorQuad.pos = glm::vec3(120,0,0);
		self.colorQuad.scale = glm::vec3(100);
		[self.worldNode addChild:self.colorQuad];
	}
	
	{
		OGMGLStandardElement * elem = OGMGLQuadElementMake([OGMGLStandardVertexFormat formatPT]);
		OGMGLQuadElementUpdateTexture(elem,mikuTexture);
		
		self.textureQuad = [[OGMGLNode alloc]initWithElement:elem];
		self.textureQuad.pos = glm::vec3(0,120,0);
		self.textureQuad.scale = glm::vec3(100);

		[self.worldNode addChild:self.textureQuad];
	}
	

	
}

-(void)viewDidLayoutSubviews{
	[super viewDidLayoutSubviews];
	
	CGRect bounds = self.view.bounds;
	float width = CGRectGetWidth(bounds);
	float height = CGRectGetHeight(bounds);
	self.camera2d.projection = glm::ortho<float>(-width/2.0,width/2.0,-height/2.0,height/2.0,0,-100.0);
}

-(void)update{
	
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
	glClearColor(0.0f, 0.0f, 0.1f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		
	self.renderer.projection.top = self.camera2d.projectionTransform;

	[self.colorTextureQuad renderWithRenderer:self.renderer];
	[self.colorQuad renderWithRenderer:self.renderer];
	[self.textureQuad renderWithRenderer:self.renderer];	
}

@end
