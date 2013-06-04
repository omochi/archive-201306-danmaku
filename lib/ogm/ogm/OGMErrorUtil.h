//
//  OGMErrorUtil.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/05.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

#ifdef __cplusplus
extern "C" {
#endif

#define _NS(name) OGM##name
#define _NSE(name) _NS(Error##name)
	
NSString * const _NSE(Domain);

typedef enum _NSE(Code){
	_NSE(NoError) = 0,
	
}_NSE(Code);

NSString * _NSE(Dump)(NSError *error);

NSError * _NSE(MakeBase)(NSString *domain,NSInteger code,NSString * format,...) NS_FORMAT_FUNCTION(3, 4);
NSError * _NSE(MakeBasev)(NSString *domain,NSInteger code,NSString * format,va_list args)NS_FORMAT_FUNCTION(3, 0);

NSError * _NSE(Make)(_NSE(Code) code,NSString * format,...) NS_FORMAT_FUNCTION(2,3);
NSError * _NSE(Makev)(_NSE(Code) code,NSString * format,va_list args) NS_FORMAT_FUNCTION(2,0);
BOOL _NSE(Is)(NSError *error,NSString * domain,NSInteger code);
	
NSException * _NS(ExceptionMake)(NSString * name,NSString *format,...) NS_FORMAT_FUNCTION(2, 3);
NSException * _NS(ExceptionMakev)(NSString * name,NSString * format,va_list args) NS_FORMAT_FUNCTION(2, 0);
NSException * _NS(ExceptionMakeWithError)(NSError * error);

#undef _NS
#undef _NSE

#ifdef __cplusplus
}
#endif

