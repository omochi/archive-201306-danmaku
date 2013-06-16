//
//  OGMGLTexture.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/15.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"
#import "OGMGLImage.h"

@interface OGMGLTexture : NSObject

@property(nonatomic,readonly)uint32_t width;
@property(nonatomic,readonly)uint32_t height;
@property(nonatomic,readonly)uint32_t imageWidth;
@property(nonatomic,readonly)uint32_t imageHeight;
@property(nonatomic,readonly)GLenum format;

@property(nonatomic,readonly)GLenum minFilter;
@property(nonatomic,readonly)GLenum magFilter;
@property(nonatomic,readonly)GLenum wrapS;
@property(nonatomic,readonly)GLenum wrapT;

-(void)prepare;

-(void)updateImage:(OGMGLImage *)image;

-(void)updateMinFilter:(GLenum)minFilter;
-(void)updateMagFilter:(GLenum)magFilter;
-(void)updateWrapS:(GLenum)wrapS;
-(void)updateWrapT:(GLenum)wrapT;

+(OGMGLTexture *)textureWithUIImage:(UIImage *)image;

@end
