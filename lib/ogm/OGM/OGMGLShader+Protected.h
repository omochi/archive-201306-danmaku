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
