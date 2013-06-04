//
//  OGMCommon.mm
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"


void _OGMLog(NSString *format,...){
	va_list args;
	va_start(args, format);
	_OGMLogv(format, args);
	va_end(args);
}
void _OGMLogv(NSString *format,va_list args){
	NSString * msg = [[NSString alloc]initWithFormat:format arguments:args];
	puts([msg UTF8String]);
}
