//
//  OGMVertex.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLVertex.h"

#import "OGMErrorUtil.h"

#define _NS(x) OGM##x
#define _NST(x) _NS(GLVertexType##x)

NSString * _NST(ToString)(_NST() type){
#define _CASE(x) case _NST(x) : return @ OGM_PP_STR(_NST(x))
	switch(type){
			_CASE(None);
			_CASE(PC);
			_CASE(PCT);
			_CASE(PCN);
			_CASE(PCTN);
		default:
			@throw OGMExceptionMake(NSInvalidArgumentException, @"unknown type: 0x%04x",type);
	}
#undef _CASE
}

size_t _NST(Size)(_NST() type){
#define _CASE(x) case _NST(x) : return sizeof(_NST(x))
	switch(type){
			_CASE(PC);
			_CASE(PCT);
			_CASE(PCN);
			_CASE(PCTN);
		default:
			@throw OGMExceptionMake(NSInvalidArgumentException, @"invalid type: 0x%04x",type);
	}
#undef _CASE
}

const char * _NST(ObjCType)(_NST() type){
#define _CASE(x) case _NST(x) : return @encode(_NS(GLVertex##x))
	switch(type){
			_CASE(PC);
			_CASE(PCT);
			_CASE(PCN);
			_CASE(PCTN);
		default:
			@throw OGMExceptionMake(NSInvalidArgumentException, @"invalid type: 0x%04x",type);
	}
#undef _CASE
}

BOOL _NST(HasUv)(_NST() type){
#define _CASE(x,r) case _NST(x) : return r
	switch(type){
			_CASE(None,NO);
			_CASE(PC,NO);
			_CASE(PCT,YES);
			_CASE(PCN,NO);
			_CASE(PCTN,YES);
		default:
			@throw OGMExceptionMake(NSInvalidArgumentException, @"unknown type: 0x%04x",type);
	}
#undef _CASE
}
BOOL _NST(HasNormal)(_NST() type){
#define _CASE(x,r) case _NST(x) : return r
	switch(type){
			_CASE(None,NO);
			_CASE(PC,NO);
			_CASE(PCT,NO);
			_CASE(PCN,YES);
			_CASE(PCTN,YES);
		default:
			@throw OGMExceptionMake(NSInvalidArgumentException, @"unknown type: 0x%04x",type);
	}
#undef _CASE
}

#undef _NST