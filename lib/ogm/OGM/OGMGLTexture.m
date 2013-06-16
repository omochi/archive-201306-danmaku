//
//  OGMGLTexture.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/15.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMErrorUtil.h"
#import "OGMGLTexture.h"
#import "OGMGLReleaser.h"

@interface OGMGLTexture()
@property(nonatomic,strong)OGMGLReleaser * glReleaser;

@property(nonatomic,assign)GLuint glTexId;
@property(nonatomic,strong)OGMGLImage * image;

@property(nonatomic,assign)BOOL textureDirty;
@property(nonatomic,assign)BOOL dataDirty;
@property(nonatomic,assign)BOOL paramsDirty;

@end

@implementation OGMGLTexture
-(id)init{
	self = [super init];
	if(self){
		_glReleaser = [[OGMGLReleaser alloc]init];
		
		_minFilter = GL_LINEAR;
		_magFilter = GL_LINEAR;
		_wrapS = GL_CLAMP_TO_EDGE;
		_wrapT = GL_CLAMP_TO_EDGE;
	}
	return self;
}

-(void)prepare{
	if(_glTexId == 0){
		glGenTextures(1, &_glTexId);
		OGMGLAssert(@"glGenTextures");
		[self.glReleaser addReleaser:^(OGMGLTexture * welf) {
			glDeleteTextures(1,&welf->_glTexId);
			OGMGLAssert(@"glDeleteTextures");
		} self:self];
	}
	
	glBindTexture(GL_TEXTURE_2D, _glTexId);
	OGMGLAssert(@"glBindTexture");
	
	if(_textureDirty){
		_textureDirty = NO;
		
		glTexImage2D(GL_TEXTURE_2D, 0, _format, _width, _height, 0, _format, GL_UNSIGNED_BYTE,NULL);
		OGMGLAssert(@"glTexImage2D");
	}
	if(_dataDirty){
		_dataDirty = NO;
		
		glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, _imageWidth, _imageHeight, _format, GL_UNSIGNED_BYTE, _image.data.bytes);
		OGMGLAssert(@"glTexSubImage2D");
		
		_image = nil;
	}
	if(_paramsDirty){
		_paramsDirty = NO;
		
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, _minFilter);
		OGMGLAssert(@"glTexParameter/minFilter");
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, _magFilter);
		OGMGLAssert(@"glTexParameter/magFilter");
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, _wrapS);
		OGMGLAssert(@"glTexParameter/wrapS");
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, _wrapT);
		OGMGLAssert(@"glTexParameter/wrapT");
	}
	
}

-(void)updateImage:(OGMGLImage *)image{
	uint32_t width = 1;
	uint32_t height = 1;
	while(width<image.width)width*=2;
	while(height<image.height)height*=2;
	
	if(_width != width || _height != height || _format != image.format){
		if(_glTexId != 0){
			@throw OGMExceptionMake(NSGenericException, @"init only");
		}
		_width = width;
		_height = height;
		_format = image.format;
		
		_textureDirty = YES;
		_paramsDirty = YES;
	}

	if(_imageWidth != image.width || _imageHeight != image.height){
		if(_glTexId != 0){
			@throw OGMExceptionMake(NSGenericException, @"init only");
		}
		
		_imageWidth = image.width;
		_imageHeight = image.height;
	}

	_image = image;
	_dataDirty = YES;
}

-(void)updateMinFilter:(GLenum)minFilter{
	if(_minFilter != minFilter){
		_paramsDirty = YES;
		_minFilter = minFilter;
	}
}
-(void)updateMagFilter:(GLenum)magFilter{
	if(_magFilter != magFilter){
		_paramsDirty = YES;
		_magFilter = magFilter;
	}
}
-(void)updateWrapS:(GLenum)wrapS{
	if(_wrapS != wrapS){
		_paramsDirty = YES;
		_wrapS = wrapS;
	}
}
-(void)updateWrapT:(GLenum)wrapT{
	if(_wrapT != wrapT){
		_paramsDirty = YES;
		_wrapT = wrapT;
	}
}

+(OGMGLTexture *)textureWithUIImage:(UIImage *)image{
	OGMGLTexture * texture = [[OGMGLTexture alloc]init];
	[texture updateImage:[[OGMGLImage alloc]initWithUIImage:image]];
	return texture;
}

@end
