//
//  OGMErrorUtil.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/05.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMErrorUtil.h"

#define _NS(name) OGM##name
#define _NSE(name) _NS(Error##name)

NSString * const _NSE(Domain) = @"com.omochimetaru.OGM.ErrorDomain";

NSString * _NSE(Dump)(NSError *error){
	NSMutableArray * lines = [NSMutableArray array];
	while(error){
		NSMutableArray * strs = [NSMutableArray arrayWithObject:[NSString stringWithFormat:@"%@(%d)",error.domain,error.code]];
		if([error localizedDescription]){
			[strs addObject:[error localizedDescription]];
		}
		if([error localizedFailureReason]){
			[strs addObject:[error localizedFailureReason]];
		}
		if([error localizedRecoverySuggestion]){
			[strs addObject:[error localizedRecoverySuggestion]];
		}
		[lines addObject:[strs componentsJoinedByString:@": "]];
		
		error = error.userInfo[NSUnderlyingErrorKey];
	}
	return [lines componentsJoinedByString:@"\n"];
}

NSError * _NSE(MakeBase)(NSString *domain,NSInteger code,NSString * format,...){
	va_list args;
	va_start(args,format);
	NSError * r = _NSE(MakeBasev)(domain, code, format, args);
	va_end(args);
	return r;
}
NSError * _NSE(MakeBaseV)(NSString *domain,NSInteger code,NSString * format,va_list args){
	NSString * desc = [[NSString alloc]initWithFormat:format arguments:args];
	return [NSError errorWithDomain:domain code:code userInfo:@{NSLocalizedDescriptionKey:desc}];
}

NSError * _NSE(Make)(_NSE(Code) code,NSString * format,...){
	va_list args;
	va_start(args,format);
	NSError * r = _NSE(Makev)(code, format, args);
	va_end(args);
	return r;
}
NSError * _NSE(Makev)(_NSE(Code) code,NSString * format,va_list args){
	return _NSE(MakeBasev)(_NSE(Domain), code, format, args);
}
BOOL _NSE(Is)(NSError *error,NSString * domain,NSInteger code){
	return [error.domain isEqualToString:domain] && error.code == code;
}

NSException *  _NS(ExceptionMake)(NSString * name,NSString *format,...){
	va_list args;
	va_start(args, format);
	NSException *e = _NS(ExceptionMakev)(name,format, args);
	va_end(args);
	return e;
}
NSException * _NS(ExceptionMakev)(NSString * name,NSString * format,va_list args){
	return [NSException exceptionWithName:name
								   reason:[[NSString alloc]initWithFormat:format arguments:args]
								 userInfo:nil];
}

NSException * _NS(ExceptionMakeWithError)(NSError * error){
	return _NS(ExceptionMake)(NSGenericException, @"%@",_NSE(Dump)(error));
}

#undef _NS
#undef _NSE
