//
//  OGMGLReleaser.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/05.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLUtil.h"

@interface OGMGLReleaser : NSObject

-(id)init;
-(void)capture:(dispatch_block_t)releaser;
-(void)addReleaser:(dispatch_block_t)releaser;

@end
