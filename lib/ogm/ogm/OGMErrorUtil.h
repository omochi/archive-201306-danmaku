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

NSString * const _NS(ErrorDomain);

typedef enum _NS(ErrorCode){
	_NS(ErrorNoError) = 0,
	
}_NS(ErrorCode);

NSString * _NS(ErrorDump)(NSError *error);

NSError * _NS(ErrorMakeBase)(NSString *domain,NSInteger code,NSString * format,...) NS_FORMAT_FUNCTION(3, 4);
NSError * _NS(ErrorMakeBasev)(NSString *domain,NSInteger code,NSString * format,va_list args)NS_FORMAT_FUNCTION(3, 0);

NSError * _NS(ErrorMake)(OGMErrorCode code,NSString * format,...) NS_FORMAT_FUNCTION(2,3);
NSError * _NS(ErrorMakev)(OGMErrorCode code,NSString * format,va_list args) NS_FORMAT_FUNCTION(2,0);

NSException * _NS(ExceptionMake)(NSString * name,NSString *format,...) NS_FORMAT_FUNCTION(2, 3);
NSException * _NS(ExceptionMakev)(NSString * name,NSString * format,va_list args) NS_FORMAT_FUNCTION(2, 0);

NSException * _NS(ExceptionMakeWithError)(NSError * error);

#undef _NS

#ifdef __cplusplus
}
#endif

