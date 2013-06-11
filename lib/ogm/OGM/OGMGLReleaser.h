//
//  OGMGLReleaser.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/05.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLUtil.h"
#import "OGMBlockUtil.h"

@interface OGMGLReleaser : NSObject

-(id)init;
//複数個登録可能だが、全部同じスレッド&コンテキストでないといけない
-(void)addReleaser:(OGMWeakSelfBlock)releaser self:(id)aSelf;


@end
