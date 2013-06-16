//
//  OGMGLShader+Protected.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLShader.h"

#import "OGMGLReleaser.h"
#import "OGMTypeBuffer.h"

#define OGM_GLSHADER_BIND_UNIFORM(prefix,var) [self bindUniform:#var ofVar:prefix##var];
#define OGM_GLSHADER_BIND_ATTRIB(prefix,var) [self bindAttribute:#var ofVar:prefix##var];

@interface OGMGLShader()

@property(nonatomic,strong)OGMGLReleaser * glReleaser;

@property(nonatomic,strong)OGMTypeBuffer * glLocationTable;

@property(nonatomic,strong)NSString * vertexShader;
@property(nonatomic,strong)NSString * fragmentShader;

-(void)setLocation:(GLint)location ofVar:(int)var;

-(void)bindUniform:(const char *)name ofVar:(int)var;
-(void)bindAttribute:(const char *)name ofVar:(int)var;

-(void)onBuild;

@end
