//
//  OGMErrorUtil.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/05.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//
#pragma once

#import "OGMCommon.h"

#ifdef __cplusplus
extern "C" {
#endif

#define _NS(name) OGM##name
#define _NSE(name) _NS(Error##name)
	
extern NSString * const _NSE(Domain);

typedef enum _NSE(Code){
	_NSE(NoError) = 0,
	_NSE(GLShaderCompileFailed) = 0x0101,
	_NSE(GLProgramLinkFailed),
}_NSE(Code);

NSString * _NSE(Dump)(NSError *error);

NSError * _NSE(MakeBase)(NSString *domain,NSInteger code,NSError *causer,NSString * format,...) NS_FORMAT_FUNCTION(4,5);
NSError * _NSE(MakeBasev)(NSString *domain,NSInteger code,NSError *causer,NSString * format,va_list args)NS_FORMAT_FUNCTION(4,0);

NSError * _NSE(Make)(_NSE(Code) code,NSError *causer,NSString * format,...) NS_FORMAT_FUNCTION(3,4);
NSError * _NSE(Makev)(_NSE(Code) code,NSError *causer,NSString * format,va_list args) NS_FORMAT_FUNCTION(3,0);
BOOL _NSE(Is)(NSError *error,NSString * domain,NSInteger code);
	
NSException * _NS(ExceptionMake)(NSString * name,NSString *format,...) NS_FORMAT_FUNCTION(2, 3);
NSException * _NS(ExceptionMakev)(NSString * name,NSString * format,va_list args) NS_FORMAT_FUNCTION(2, 0);
NSException * _NS(ExceptionMakeWithError)(NSError * error);

#undef _NS
#undef _NSE

#ifdef __cplusplus
}
#endif

