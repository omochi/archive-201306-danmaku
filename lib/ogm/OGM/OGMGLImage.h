//
//  OGMGLImage.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/14.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

@interface OGMGLImage : NSObject

@property(nonatomic,readonly)uint32_t width;
@property(nonatomic,readonly)uint32_t height;
@property(nonatomic,readonly)GLenum format;
@property(nonatomic,readonly)NSData * data;

-(id)initWithUIImage:(UIImage *)image;
-(id)initWithCGImage:(CGImageRef)image;

@end
