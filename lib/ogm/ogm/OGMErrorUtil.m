//
//  OGMErrorUtil.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/05.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMErrorUtil.h"

#define _NS(name) OGM##name

NSString * const _NS(ErrorDomain) = @"com.omochimetaru.OGM.ErrorDomain";

NSString * _NS(ErrorDump)(NSError *error){
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

NSError * _NS(ErrorMakeBase)(NSString *domain,NSInteger code,NSString * format,...){
	va_list args;
	va_start(args,format);
	NSError * r = _NS(ErrorMakeBasev)(domain, code, format, args);
	va_end(args);
	return r;
}
NSError * _NS(ErrorMakeBaseV)(NSString *domain,NSInteger code,NSString * format,va_list args){
	NSString * desc = [[NSString alloc]initWithFormat:format arguments:args];
	return [NSError errorWithDomain:domain code:code userInfo:@{NSLocalizedDescriptionKey:desc}];
}

NSError * _NS(ErrorMake)(_NS(ErrorCode) code,NSString * format,...){
	va_list args;
	va_start(args,format);
	NSError * r = _NS(ErrorMakev)(code, format, args);
	va_end(args);
	return r;
}
NSError * _NS(ErrorMakev)(_NS(ErrorCode) code,NSString * format,va_list args){
	return _NS(ErrorMakeBasev)(_NS(ErrorDomain), code, format, args);
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
	return _NS(ExceptionMake)(NSGenericException, @"%@",_NS(ErrorDump)(error));
}

#undef _NS
